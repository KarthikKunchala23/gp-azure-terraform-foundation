variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}


variable "subnets" {
  description = "List of subnet configurations"

  type = list(object({
    name           = string
    address_prefix = string

    default_outbound_access_enabled = optional(bool, false)

    private_endpoint_network_policies = optional(
      string,
      "Disabled"
    )

    security_group_id = optional(string, null)

    private_link_service_network_policies = optional(
      bool,
      true
    )

    service_endpoint = optional(list(string), [])
  }))
}


variable "tags" {
  description = "A map of tags to apply to the resources"
  type        = map(string)
}