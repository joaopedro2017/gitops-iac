resource "azurerm_subnet" "subnet" {
  name                 = "gitops-subnet-backend"
  resource_group_name  = azurerm_resource_group.gitops_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/22"]
}
