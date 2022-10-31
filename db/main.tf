resource "azurerm_private_dns_zone" "this" {
  resource_group_name = var.resource_group_name
  name                = "${var.name}-z.postgres.database.azure.com"
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  depends_on = [
    azurerm_private_dns_zone.this
  ]
  resource_group_name = var.resource_group_name

  name                  = "${var.name}-vnet-zone.local"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

resource "azurerm_postgresql_flexible_server" "this" {
  depends_on = [
    azurerm_private_dns_zone.this,
    azurerm_private_dns_zone_virtual_network_link.this
  ]
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name                   = var.name
  version                = "13"
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  delegated_subnet_id    = var.database_subnet_id
  zone                   = 2
  administrator_login    = var.db_username
  administrator_password = var.db_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  tags                   = var.tags
}
