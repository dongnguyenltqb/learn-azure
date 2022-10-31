resource "azurerm_application_security_group" "api" {
  name                = "api-asg"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  tags                = var.tags
}
