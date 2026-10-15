variable "nat_name" {
  description = "Name of the nat"
  type        = string
}

variable "location" {
  description = "Location of the nat"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate with the NAT gateway"
  type        = string
}


