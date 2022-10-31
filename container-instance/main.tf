resource "azurerm_network_profile" "app" {
  name                = var.app_profile_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = var.app_profile_name

    ip_configuration {
      name      = var.app_profile_name
      subnet_id = var.subnet_id
    }


  }
}

resource "azurerm_container_group" "api" {
  name                = var.api_container_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"

  network_profile_id = azurerm_network_profile.app.id

  image_registry_credential {
    server   = var.server
    username = var.username
    password = var.password

  }

  container {
    name   = "api"
    image  = "nginx:latest"
    cpu    = "0.25"
    memory = "1"

    ports {
      port     = 3003
      protocol = "TCP"
    }
  }

  tags = var.tags
}
