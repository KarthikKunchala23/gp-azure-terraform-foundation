terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.6.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestorage230"
    container_name       = "foundation"
    key                  = "vnet/terraform.tfstate"
    subscription_id      = "0814711d-f7c1-40aa-9f77-18fec1afe80d"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "0814711d-f7c1-40aa-9f77-18fec1afe80d"
}