resource "azurerm_subnet_network_security_group_association" "bastion" {
  depends_on = [
    azurerm_subnet.database
  ]
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

resource "azurerm_subnet_network_security_group_association" "public" {
  depends_on = [
    azurerm_subnet.public
  ]
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_subnet_network_security_group_association" "db" {
  depends_on = [
    azurerm_subnet.database
  ]
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.database.id
}

resource "azurerm_subnet_network_security_group_association" "application" {
  depends_on = [
    azurerm_subnet.application
  ]
  subnet_id                 = azurerm_subnet.application.id
  network_security_group_id = azurerm_network_security_group.application.id
}

resource "azurerm_subnet_network_security_group_association" "trusted" {
  depends_on = [
    azurerm_subnet.trusted
  ]
  subnet_id                 = azurerm_subnet.trusted.id
  network_security_group_id = azurerm_network_security_group.trusted.id
}


resource "azurerm_subnet_nat_gateway_association" "application-nat" {
  subnet_id      = azurerm_subnet.application.id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

resource "azurerm_subnet_nat_gateway_association" "trusted-nat" {
  subnet_id      = azurerm_subnet.trusted.id
  nat_gateway_id = azurerm_nat_gateway.this.id
}

