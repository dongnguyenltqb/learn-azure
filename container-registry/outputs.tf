output "registry_url" {
  value = azurerm_container_registry.acr.login_server
}

output "registry_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "registry_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
