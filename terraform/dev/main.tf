resource "azurerm_resource_group" "rg" {
  name     = "demo-rg-terraform"
  location = "southindia"
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "demo-vnet-terraform"
  location            = "southindia"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  subnets = [
    {
      name                            = "public-subnet"
      address_prefix                  = "10.0.1.0/24"
      default_outbound_access_enabled = true
    },
    {
      name                            = "private-subnet"
      address_prefix                  = "10.0.2.0/24"
      default_outbound_access_enabled = false
    }
  ]
  tags = {
    environment = "dev"
    project     = "demo-terraform"
  }
}