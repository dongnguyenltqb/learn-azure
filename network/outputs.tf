output "vnet_id" {
  value = azurerm_virtual_network.this.id
}


output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "nat_ip" {
  value = azurerm_public_ip.nat.ip_address
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "application_subnet_id" {
  value = azurerm_subnet.application.id
}

output "bastion_nsg_id" {
  value = azurerm_network_security_group.bastion.id
}

output "application_nsg_id" {
  value = azurerm_network_security_group.application.id
}

output "trusted_nsg_id" {
  value = azurerm_network_security_group.trusted.id
}


output "api_asg_id" {
  value = azurerm_application_security_group.api.id
}

output "trusted_subnet_id" {
  value = azurerm_subnet.trusted.id
}



