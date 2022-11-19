resource "azurerm_public_ip" "public_ip" {
  name                = "production_vm_public_ip"
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "gitops-nic"
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_windows_virtual_machine" "virtual_machine" {
  name                = "prodution-vm"
  computer_name       = "prodution-vm"
  resource_group_name = azurerm_resource_group.gitops_rg.name
  location            = azurerm_resource_group.gitops_rg.location
  size                = "Standard_D2as_v4"
  admin_username      = var.ADM_USER_VM_NAME
  admin_password      = var.ADM_USER_VM_PASS

  network_interface_ids = [
    azurerm_network_interface.nic.id
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
