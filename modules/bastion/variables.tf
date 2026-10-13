variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID of the subnet for the Bastion host"
  type        = string
}

variable "copy_paste_enabled" {
  description = "Enable or disable copy-paste functionality in Bastion"
  type        = bool
  default     = false
}

variable "file_copy_enabled" {
  description = "Enable or disable file copy functionality in Bastion"
  type        = bool
  default     = false
}

variable "scale_units" {
  description = "Number of scale units for the Bastion host"
  type        = number
  default     = 1
}