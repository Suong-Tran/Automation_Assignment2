module "resource_group" {
  source   = "./modules/resource_group"
  rg      = "3552-Assignment2-RG"
  location = "Japan East"
}


module "network" {
  source        = "./modules/network"
  rg          = module.resource_group.rg.name
  location      = module.resource_group.rg.location
  vnet          = "vnet"
  vnet_space    = ["10.0.0.0/16"]
  subnet      = "subnet"
  subnet_space = ["10.0.1.0/24"]
  nsg          = "nsg"
  depends_on    = [module.resource_group]
}

module "common" {
  source     = "./modules/common"
  rg        = module.resource_group.rg.name
  location   = module.resource_group.rg.location
  depends_on = [module.resource_group]

}



module "linux" {
  source     = "./modules/linux"
  linux_name                 = {linux-centos-vm = "Standard_B1s"
                                linux-centos-vm1 = "Standard_B1s"              }
  linux_avs  = "linux-avs"
  linux_rg  = module.resource_group.rg.name
  location   = module.resource_group.rg.location
  subnet     = module.network.subnet_id
  depends_on = [module.network]
}

module "windows" {
  source      = "./modules/windows"
  windows_avs = "windows-avs"
  windows_name = {
    terrafrom-w-vm1 = "Standard_B1s"
  }
  win_rg    = module.resource_group.rg.name
  location   = module.resource_group.rg.location
  subnet    = module.network.subnet_id
  depends_on = [module.network]

}



module "datadisk" {
  source                     = "./modules/datadisk"
  rg                        = module.resource_group.rg.name
  location                   = module.resource_group.rg.location
  linux_name                 = {linux-centos-vm = "Standard_B1s"
                                linux-centos-vm1 = "Standard_B1s"              }
  linux_virtual_machine_ids  = [module.linux.linux_virtual_machine_ids]
  windows_name               = { win-server-vm = "Standard_B1s" }
  window_virtual_machine_ids = [module.windows.window_virtual_machine_ids]
  depends_on                 = [module.windows]


}

module "load_balancer" {
  source               = "./modules/load_balancer"
  rg                  = module.resource_group.rg.name
  location             = module.resource_group.rg.location
  public_ip_address_id = [module.linux.Linux_public_ip_addresses]
  network_interface_id = [module.linux.network_interface_id]
  depends_on           = [module.network, module.linux]

}

module "database" {
  source     = "./modules/database"
  rg        = module.resource_group.rg.name
  location   = module.resource_group.rg.location
  depends_on = [module.network]
}

resource "null_resource" "ansible-deploy" {
  depends_on = [module.datadisk]
  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook --private-key /home/yangy/.ssh/id_rsa -i hosts groupX-playbook.yml"
  }
}
