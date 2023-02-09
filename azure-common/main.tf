terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
 features {}
}


####

resource "azurerm_resource_group" "common" {
    name     = "common-${var.location}-rg"
    location = var.location
}

resource "azurerm_network_security_group" "hub" {
  name                = "hub-${var.location}-nsg"
  location            = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name
}

resource "azurerm_virtual_network" "hub" {
  name                = "hub-${var.location}-network"
  location            = azurerm_resource_group.common.location
  resource_group_name = azurerm_resource_group.common.name
  address_space       = ["10.200.0.0/16"]

  subnet {
    name           = "hub-${var.location}-subnet"
    address_prefix = "10.200.0.0/24"
    security_group = azurerm_network_security_group.hub.id
  }

}

resource "azurerm_key_vault" "hub" {
  name                              = "hub-${var.location}-kv"
  location                          = azurerm_resource_group.common.location
  resource_group_name               = azurerm_resource_group.common.name
  enabled_for_deployment            = true
  enabled_for_disk_encryption       = true
  enabled_for_template_deployment   = true
  enable_rbac_authorization         = true
  tenant_id                         = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days        = 7
  purge_protection_enabled          = false
  sku_name = "standard"
}

resource "azurerm_role_assignment" "adOwner" {
  scope                = azurerm_key_vault.hub.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.rbac_owner
}