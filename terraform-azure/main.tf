terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "HashiTalksLatam2024S1"
    }
  }
  required_version = "= 1.6.6"
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "= 1.33.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.84.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "genericRG" {
  name     = "${var.suffix}${var.rgName}"
  location = var.location
  tags     = var.tags
}
