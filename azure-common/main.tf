terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.42.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
}


####

resource "azurerm_resource_group" "this" {
    name     = "common-${var.location}-rg"
    location = var.location
}