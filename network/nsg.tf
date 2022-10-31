# Create azure NSG for public subnet
resource "azurerm_network_security_group" "public" {
  name                = "public-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "GatewayManager"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }
}


# Create azure NSG for bastion subnet
resource "azurerm_network_security_group" "bastion" {
  name                = "bastion-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "allow-ssh-to-bastion-vm"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefixes    = ["0.0.0.0/0"]
    source_port_range          = "*"
    destination_port_range     = "22"
    destination_address_prefix = var.bastion_subnet_cidr
  }

  security_rule {
    name                       = "allow-pg-to-bastion-vm"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefixes    = ["42.114.219.78/32", "14.241.251.235/32", "8.39.127.97/32"]
    source_port_range          = "*"
    destination_port_range     = "5432"
    destination_address_prefix = var.bastion_subnet_cidr
  }
}


# Create azure NSG for application subnet
resource "azurerm_network_security_group" "application" {
  depends_on = [
    azurerm_application_security_group.api
  ]
  name                = "app-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = "GatewayManager"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "GatewayManager"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AzureLoadBalancer"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "AzureLoadBalancer"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "Bastion"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = var.bastion_subnet_cidr
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "PublicSubnet"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = var.public_subnet_cidr
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "all-inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "VirtualNetwork"
  }
}

# Create azure NSG for database subnet
resource "azurerm_network_security_group" "database" {
  name                = "db-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name      = "allow-connection-from-bastion"
    priority  = 100
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    // alow connection from application subnet
    source_address_prefix      = var.bastion_subnet_cidr
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = var.database_subnet_cidr
  }

  security_rule {
    name      = "allow-connection-from-application-subnet"
    priority  = 101
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    // alow connection from application subnet
    source_address_prefixes    = [var.application_subnet_cidr]
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = var.database_subnet_cidr
  }

  security_rule {
    name      = "deny-all-inbound"
    priority  = 102
    direction = "Inbound"
    access    = "Deny"
    protocol  = "Tcp"
    // alow connection from application subnet
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = var.database_subnet_cidr
  }

  security_rule {
    name                       = "deny-all-internet"
    priority                   = 103
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "Internet"
  }
}

# Create azure NSG for trusted subnet
resource "azurerm_network_security_group" "trusted" {
  name                = "trusted-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "ssh-from-bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefixes    = [var.bastion_subnet_cidr]
    source_port_range          = "*"
    destination_port_range     = "22"
    destination_address_prefix = var.trusted_subnet_cidr
  }

  security_rule {
    name                       = "all-inbound"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "vnet-outbound"
    priority                   = 103
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_address_prefix = "VirtualNetwork"
    destination_port_range     = "*"
  }

  security_rule {
    name                       = "internet-outbound"
    priority                   = 104
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_address_prefix = "Internet"
    destination_port_range     = "*"
  }
}
