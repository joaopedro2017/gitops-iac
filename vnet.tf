resource "azurerm_virtual_network" "vnet" {
  name                = "VNET-gitops"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "gitops-subnet-backend"
  resource_group_name  = azurerm_resource_group.gitops_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/22"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "production-nsg"
  location            = azurerm_resource_group.gitops_rg.location
  resource_group_name = azurerm_resource_group.gitops_rg.name

  security_rule {
    name                       = "AllowAnyCustom3389Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
