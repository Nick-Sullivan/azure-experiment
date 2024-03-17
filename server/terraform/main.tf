terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "TerraformStates"
    storage_account_name = "nicksterraform"
    container_name       = "tfstates"
    key                  = "azure_experiment.dev.terraform.tfstate"
    use_oidc = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
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
