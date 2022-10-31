output "web_ip" {
  value = azurerm_container_group.web[*].ip_address
}

output "api_ip" {
  value = azurerm_container_group.api.ip_address
}

output "backoffice_ip" {
  value = azurerm_container_group.backoffice.ip_address
}


