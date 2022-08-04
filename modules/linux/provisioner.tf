resource "null_resource" "linux_provisioner" {
  for_each = var.linux_name
  depends_on = [azurerm_linux_virtual_machine.vmlinux]

  provisioner "remote-exec" {
    inline = ["/usr/bin/hostname"]
    connection {
      type     = "ssh"
      user     = var.admin_username
      private_key = file(var.priv_key)
      host     = azurerm_public_ip.linux_pip[each.key].fqdn
  }
 }
}

