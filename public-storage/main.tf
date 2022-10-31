resource "azurerm_storage_account" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name

  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  shared_access_key_enabled     = true
  public_network_access_enabled = true

  network_rules {
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"]
  }

  blob_properties {
    cors_rule {
      max_age_in_seconds = 3600
      allowed_methods    = ["GET", "PATCH", "HEAD", "POST", "DELETE", "PUT", "OPTIONS"]
      allowed_headers    = ["*"]
      exposed_headers    = ["*"]
      allowed_origins    = var.allowed_origins
    }
  }

  tags = var.tags
}
