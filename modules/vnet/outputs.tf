output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "vnet_location" {
  value = azurerm_virtual_network.this.location
}

output "vnet_address_space" {
  value = azurerm_virtual_network.this.address_space
}

output "subnet_ids" {
  value = [for subnet in azurerm_virtual_network.this.subnet : subnet.id]
}