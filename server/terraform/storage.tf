
# There is a known issue when destroying/creating a storage account with the same name.
# This suffix is a workaround: https://github.com/hashicorp/terraform-provider-azurerm/issues/10872
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

# Storage account holds the compiled source code to be executed by the Azure function.
resource "azurerm_storage_account" "example" {
  # max of 24 chars
  name                     = "${local.prefix_short}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # LRS is cheapest
}

# Deny all access to the storage account, except for the Azure function metrics
# resource "azurerm_storage_account_network_rules" "example" {
#   storage_account_id         = azurerm_storage_account.example.id
#   default_action             = "Deny"
#   ip_rules                   = ["100.0.0.1"]
#   virtual_network_subnet_ids = [azurerm_subnet.example.id]
#   bypass                     = ["Metrics"]
#   private_link_access {
#     endpoint_resource_id = azurerm_windows_function_app.example.id
#   }
# }

# Create a private endpoint that allows use of the storage subnet
# resource "azurerm_private_endpoint" "main" {
#   name                = "storage"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   subnet_id           = azurerm_subnet.storage.id
#   private_service_connection {
#     name                           = "storageAccountConnection"
#     private_connection_resource_id = azurerm_storage_account.example.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }
# }
