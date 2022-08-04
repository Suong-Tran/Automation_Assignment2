output "Virtual_network_name" {
  value = module.network.Virtual_network_name

}

output "Subnet" {
  value = module.network.subnet_name

}

output "Linux_hostname" {
  value = module.linux.Linux_hostname

}

output "Linux_private_ip_addresses" {
  value = module.linux.Linux_private_ip_addresses

}

output "Linux_public_ip_addresses" {
  value = module.linux.Linux_public_ip_addresses

}

output "Linux_domain_names" {
  value = module.linux.linux_domain_names

}

output "linux_nic" {
  value = module.linux.linux_nic

}


output "windows_hostname" {
  value = module.windows.windows_hostname

}

output "windows_private_ip_addresses" {
  value = module.windows.windows_private_ip_addresses

}

output "windows_public_ip_addresses" {
  value = module.windows.windows_public_ip_addresses

}

output "window_virtual_machine_ids" {
  value = module.windows.window_virtual_machine_ids

}
