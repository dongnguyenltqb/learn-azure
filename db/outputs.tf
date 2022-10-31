output "db_host" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}
