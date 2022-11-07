variable "resource_group_name" {
  default = "eastus2-gitops-terraform-rg"
}

variable "location" {
  default = "eastus2"
}

variable "virtual_network_name" {
  default = "VNET-gitops"
}

variable "subnet_name" {
  default = "aks-subnet-backend"
}
