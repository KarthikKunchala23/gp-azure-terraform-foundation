
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  dynamic "subnet" {
    for_each = var.subnets

    content {
      name             = subnet.value.name
      address_prefixes = [subnet.value.address_prefix]

      default_outbound_access_enabled = (
        subnet.value.default_outbound_access_enabled
      )

      private_endpoint_network_policies = (
        subnet.value.private_endpoint_network_policies
      )

      private_link_service_network_policies_enabled = (
        subnet.value.private_link_service_network_policies
      )

      dynamic "service_endpoint" {
        for_each = subnet.value.service_endpoint

        content {
          service = service_endpoint.value
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.vnet_name
    }
  )
}
