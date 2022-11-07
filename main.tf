terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "eastus2-gitops-bkp-rg"
    storage_account_name = "gitopsiac"
    container_name       = "terraformbkp"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
