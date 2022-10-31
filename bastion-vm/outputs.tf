output "bastion-eip" {
  value = azurerm_public_ip.ip.ip_address
}

output "bastion-username" {
  value = "adminuser"
}
