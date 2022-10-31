resource "azurerm_container_registry" "acr" {
  name                          = var.container_registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  sku                           = "Standard"
  admin_enabled                 = true
  public_network_access_enabled = true
}
