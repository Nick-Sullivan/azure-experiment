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
    use_oidc             = true
  }
}

provider "azurerm" {
  features {
    application_insights {
      disable_generated_rule = true
    }
  }
  use_oidc = true
}

locals {
  prefix       = "AzureExperiment-${title(var.environment)}"
  prefix_lower = "azureexperiment${lower(var.environment)}"
  prefix_short = "azex${lower(var.environment)}"
  root_dir     = "${path.root}/.."
  src_dir      = "${local.root_dir}/src"

  tags = {
    Project     = "Azure Experiment"
    Environment = lower(var.environment)
  }
}

# A grouping of all resources associated with this project
resource "azurerm_resource_group" "example" {
  name     = local.prefix
  location = "australiasoutheast"
}
