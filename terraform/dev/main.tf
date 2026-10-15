locals {
  location = "southindia"

  tags = {
    environment = "dev"
    project     = "demo-terraform"
  }

  # One entry per subnet. Each entry carries the security rules for the NSG
  # that gets created and attached to that subnet.
  subnets = {
    public-subnet = {
      address_prefix                  = "10.0.1.0/24"
      default_outbound_access_enabled = true
      service_endpoint                = []
      security_rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "10.0.3.0/24"
          destination_address_prefix = "*"
        },
        {
          name                       = "DenyHTTP"
          priority                   = 200
          direction                  = "Outbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "DenyHTTPS"
          priority                   = 201
          direction                  = "Outbound"
          access                     = "Deny"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }

    private-subnet = {
      address_prefix                  = "10.0.2.0/24"
      default_outbound_access_enabled = false
      service_endpoint                = []
      security_rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "10.0.3.0/24"
          destination_address_prefix = "*"
        }
        #  This rules are commented out because the NAT Gateway module will create a default outbound rule that allows all outbound traffic.
        #  If you want to restrict outbound traffic, you can uncomment these rules and adjust them as needed.
        # {
        #   name                       = "DenyHTTP"
        #   priority                   = 200
        #   direction                  = "Outbound"
        #   access                     = "Deny"
        #   protocol                   = "*"
        #   source_port_range          = "*"
        #   destination_port_range     = "80"
        #   source_address_prefix      = "*"
        #   destination_address_prefix = "*"
        # },
        # {
        #   name                       = "DenyHTTPS"
        #   priority                   = 201
        #   direction                  = "Outbound"
        #   access                     = "Deny"
        #   protocol                   = "*"
        #   source_port_range          = "*"
        #   destination_port_range     = "443"
        #   source_address_prefix      = "*"
        #   destination_address_prefix = "*"
        # }
      ]
    }

    # Azure validates the NSG attached to AzureBastionSubnet and rejects the
    # deployment unless these rules are present.
    AzureBastionSubnet = {
      address_prefix                  = "10.0.3.0/24"
      default_outbound_access_enabled = true
      service_endpoint                = []
      security_rules = [
        {
          name                       = "AllowHttpsInbound"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowGatewayManagerInbound"
          priority                   = 130
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "GatewayManager"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowAzureLoadBalancerInbound"
          priority                   = 140
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowBastionHostCommunicationInbound8080"
          priority                   = 150
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "8080"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowBastionHostCommunicationInbound5701"
          priority                   = 151
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "5701"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowSshOutbound"
          priority                   = 100
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowRdpOutbound"
          priority                   = 110
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "3389"
          source_address_prefix      = "*"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowAzureCloudOutbound"
          priority                   = 120
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "AzureCloud"
        },
        {
          name                       = "AllowBastionCommunicationOutbound8080"
          priority                   = 130
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "8080"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowBastionCommunicationOutbound5701"
          priority                   = 131
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "5701"
          source_address_prefix      = "VirtualNetwork"
          destination_address_prefix = "VirtualNetwork"
        },
        {
          name                       = "AllowGetSessionInformationOutbound"
          priority                   = 140
          direction                  = "Outbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "Internet"
        }
      ]
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "demo-rg-terraform"
  location = local.location
}

# One NSG per subnet, created before the VNet so each subnet can reference it.
module "nsg" {
  source   = "../../modules/nsg"
  for_each = local.subnets

  nsg_name            = "nsg-${each.key}"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rules      = each.value.security_rules
  tags                = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "demo-vnet-terraform"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  subnets = [
    for name, config in local.subnets : {
      name                            = name
      address_prefix                  = config.address_prefix
      default_outbound_access_enabled = config.default_outbound_access_enabled
      service_endpoint                = config.service_endpoint
      security_group_id               = module.nsg[name].nsg_id
    }
  ]

  tags = local.tags
}

# Bastion host module
module "bastion" {
  source              = "../../modules/bastion"
  prefix              = "demo"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  bastion_subnet_id   = module.vnet.subnet_ids["AzureBastionSubnet"]
  copy_paste_enabled  = true
  file_copy_enabled   = true
  scale_units         = 2
}

# NAT Gateway module
module "nat" {
  source              = "../../modules/nat"
  nat_name            = "demo"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.vnet.subnet_ids["private-subnet"]
}