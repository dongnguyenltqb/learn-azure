resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}


module "acr" {
  source                  = "./container-registry"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  container_registry_name = var.container_registry_name
}


module "network" {
  source                  = "./network"
  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  name                    = var.vnet_name
  vnet_cidr               = var.vnet_cidr
  public_subnet_cidr      = var.public_subnet_cidr
  bastion_subnet_cidr     = var.bastion_subnet_cidr
  application_subnet_cidr = var.application_subnet_cidr
  trusted_subnet_cidr     = var.trusted_subnet_cidr
  database_subnet_cidr    = var.database_subnet_cidr
  tags = merge(var.tags, {
    Component = "Network"
  })
}

module "container" {
  depends_on = [
    module.network,
    module.acr
  ]
  source                  = "./container-instance"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  subnet_id               = module.network.application_subnet_id
  app_profile_name        = var.app_profile_name

  username = module.acr.registry_username
  password = module.acr.registry_password
  server   = module.acr.registry_url

  web_container_name        = var.web_container_name
  api_container_name        = var.api_container_name
  backoffice_container_name = var.backoffice_container_name

  tags = merge(var.tags, {
    Component = "App Container"
  })

}

module "public-storage" {
  source                  = "./public-storage"
  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  name = var.storage_account_name

  tags = merge(var.tags, {
    Component = "Public Storage"
  })
}


module "db" {
  depends_on = [
    module.network
  ]
  source                  = "./db"
  name                    = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  vnet_id                 = module.network.vnet_id
  database_subnet_id      = module.network.database_subnet_id
  tags = merge(var.tags, {
    Component = "Database"
  })
}

module "bastion-vm" {
  depends_on = [
    module.network,
    module.db
  ]
  source                  = "./bastion-vm"
  name                    = "bastion-vm"
  bastion_subnet_cidr     = var.bastion_subnet_cidr
  public_key              = file("./ssh-keys/bastion-vm.pub")
  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  bastion_subnet_id       = module.network.bastion_subnet_id
  bastion_nsg_id          = module.network.bastion_nsg_id
  tags = merge(var.tags, {
    Component = "Bastion Host"
  })
}
