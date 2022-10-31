# Create a azure VNet
resource "azurerm_virtual_network" "this" {
  name                = "${var.name}-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
}
