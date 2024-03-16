terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
  backend "s3" {
    bucket = "nicks-terraform-states"
    region = "ap-southeast-2"
    key    = "azure_experiment/dev/infrastructure/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

locals {
  prefix       = "AzureExperiment-Dev"
  prefix_lower = "azureexperimentdev"
  root_dir     = "${path.root}/.."
  src_dir      = "${local.root_dir}/src"

  tags = {
    Project     = "Azure Experiment"
    Environment = "dev"
  }
}

# A grouping of all resources associated with this project
resource "azurerm_resource_group" "example" {
  name     = local.prefix
  location = "australiasoutheast"
}
