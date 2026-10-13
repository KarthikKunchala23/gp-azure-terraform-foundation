output "id" {
  value = azurerm_bastion_host.this.id
}

output "dns_name" {
  value = azurerm_bastion_host.this.dns_name
}

output "public_ip_address" {
  value = azurerm_public_ip.bastion.ip_address
}

output "private_only_enabled" {
  value = azurerm_bastion_host.this.private_only_enabled
}