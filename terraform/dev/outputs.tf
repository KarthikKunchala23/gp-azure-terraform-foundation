output "network_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}
output "nsg_ids" {
  description = "NSG id for each subnet, keyed by subnet name"
  value       = { for name, nsg in module.nsg : name => nsg.nsg_id }
}
