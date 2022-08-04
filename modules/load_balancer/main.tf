resource "azurerm_public_ip" "lbpubip" {
  name                = "publicIPLB"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  domain_name_label  = "assignment2-3552"
}


resource "azurerm_lb" "assignment2" {
  name                = "lb-assignment1-3552"
  location            = var.location
  resource_group_name = var.rg
  tags                  = local.common_tags
  frontend_ip_configuration {
    name                 = "PublicIPAddress-3552"
    public_ip_address_id = azurerm_public_ip.lbpubip.id
    
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id     = azurerm_lb.assignment2.id
  name                = "BackEndAddressPool-3552"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_association" {
  network_interface_id    = element(var.network_interface_id, 0)[0]
  ip_configuration_name   = "linux-centos-vm-ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_association2" {
  network_interface_id    = element(var.network_interface_id, 1)[1]
  ip_configuration_name   = "linux-centos-vm1-ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id
}


resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.assignment2.id
  name                           = "LBRule-3552"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress-3552"
}

resource "azurerm_lb_probe" "lb_prob" {
  loadbalancer_id     = azurerm_lb.assignment2.id
  name                = "tcpProbe"
  protocol            = "Http"
  request_path        = "/health"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}


resource "azurerm_lb_nat_rule" "nat_rule" {
  resource_group_name = var.rg
  loadbalancer_id     = azurerm_lb.assignment2.id
  name                           = "RDPAccess"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress-3552"
}
