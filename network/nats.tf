resource "azurerm_public_ip" "nat" {
  name                = "nat-gateway-public-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
  public_ip_prefix_id = azurerm_public_ip_prefix.this.id
}

resource "azurerm_public_ip_prefix" "this" {
  name                = "nat-gateway-public-ip-prefix"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "this" {
  name                    = "nat-gw"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}


resource "azurerm_nat_gateway_public_ip_association" "this" {
  depends_on = [
    azurerm_nat_gateway.this,
    azurerm_public_ip.nat
  ]
  public_ip_address_id = azurerm_public_ip.nat.id
  nat_gateway_id       = azurerm_nat_gateway.this.id
}
