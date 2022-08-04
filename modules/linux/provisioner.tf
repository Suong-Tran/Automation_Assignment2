resource "null_resource" "linux_provisioner" {
  for_each = var.linux_name
  depends_on = [azurerm_linux_virtual_machine.vmlinux]

  provisioner "local-exec" {
    command = "sleep 2m; ansible-playbook groupX-playbook.yml"
    connection {
      type     = "ssh"
      user     = var.admin_username
      private_key = file(var.priv_key)
      timeout = "45"
      host     = azurerm_public_ip.linux_pip[each.key].fqdn
  }
 }
}

