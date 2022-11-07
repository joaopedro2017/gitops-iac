resource "azurerm_network_interface" "nic" {
  name                = "gitops-nic"
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "virtual_machine" {
  name                = var.virtual_machine_name
  computer_name       = var.virtual_machine_name
  resource_group_name = azurerm_resource_group.gitops_rg.name
  location            = azurerm_resource_group.gitops_rg.location
  size                = "Standard_D2as_v4"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
