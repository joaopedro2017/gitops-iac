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

variable "virtual_machine_name" {
  default = "prodution-vm"
}

variable "virtual_machine_size" {
  default = "Standard_D2as_v4"
}

variable "network_interface_name" {
  default = "production-nic"
}
