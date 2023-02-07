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
    security_group = azurerm_network_security_group.hub
  }

}