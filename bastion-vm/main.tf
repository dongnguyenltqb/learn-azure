resource "azurerm_public_ip" "ip" {
  name                = "${var.name}-ip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_network_interface" "this" {
  depends_on = [
    azurerm_public_ip.ip
  ]
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.bastion_subnet_id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.ip.id
    private_ip_address            = cidrhost(var.bastion_subnet_cidr, 10)
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "this" {
  depends_on = [
    azurerm_network_interface.this
  ]
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = var.bastion_nsg_id

}

resource "azurerm_linux_virtual_machine" "this" {
  depends_on = [
    azurerm_network_interface.this
  ]
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_F1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    version   = "latest"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
  }
  tags = var.tags
}
