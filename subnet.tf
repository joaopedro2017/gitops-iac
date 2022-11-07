resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.gitops_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/22"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.subnet_name
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name  
}

resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
