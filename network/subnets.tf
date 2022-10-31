// Bastion subnet
resource "azurerm_subnet" "bastion" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  resource_group_name  = var.resource_group_name
  name                 = "bastion-subnet"
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

// Public subnet
resource "azurerm_subnet" "public" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  resource_group_name  = var.resource_group_name
  name                 = "public-subnet"
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.public_subnet_cidr]
}


// Application subnet
resource "azurerm_subnet" "application" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  resource_group_name  = var.resource_group_name
  name                 = "application-subnet"
  virtual_network_name = azurerm_virtual_network.this.name
  service_endpoints    = ["Microsoft.Storage", ]
  address_prefixes     = [var.application_subnet_cidr]
  delegation {
    name = var.name

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

// Trusted subnet
resource "azurerm_subnet" "trusted" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  name                 = "trusted-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.trusted_subnet_cidr]
}

// Database subnet
resource "azurerm_subnet" "database" {
  depends_on = [
    azurerm_virtual_network.this
  ]
  name                 = "database-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.database_subnet_cidr]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
