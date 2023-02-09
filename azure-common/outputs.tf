## Resource Group
output "azurerm_resource_group_name" {
  value = azurerm_resource_group.common.name
}

output "azurerm_resource_group_location" {
  value = azurerm_resource_group.common.location
}

output "azurerm_resource_group_id" {
  value = azurerm_resource_group.common.id
}

## NSG
output "azurerm_network_security_group_id" {
  value = azurerm_network_security_group.hub.id
}

## VNET
output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.hub.name
}

output "azurerm_virtual_network_id" {
  value = azurerm_virtual_network.hub.id
}

output "azurerm_virtual_network_guid" {
  value = azurerm_virtual_network.hub.guid
}

output "azurerm_virtual_network_address_space" {
  value = azurerm_virtual_network.hub.address_space
}

output "azurerm_virtual_network_subnet_hub_id" {
  value = azurerm_virtual_network.hub.subnet.*.id[0]
}

output "azurerm_key_vault_id" {
  value = azurerm_key_vault.hub.id
}

output "azurerm_key_vault_uri" {
  value = azurerm_key_vault.hub.vault_uri
}