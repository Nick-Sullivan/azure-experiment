
# There is a known issue when destroying/creating a storage account with the same name.
# This suffix is a workaround: https://github.com/hashicorp/terraform-provider-azurerm/issues/10872
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "example" {
  name                     = "${local.prefix_lower}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # LRS is cheapest
}
