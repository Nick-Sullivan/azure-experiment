
# # Option 1 - deploy without the code
# # this would be nicer but i'm struggling to get CICD to work with the publish profile
# resource "azurerm_windows_function_app" "example" {
#   name                       = local.prefix
#   resource_group_name        = azurerm_resource_group.example.name
#   location                   = azurerm_resource_group.example.location
#   service_plan_id            = azurerm_service_plan.example.id
#   storage_account_name       = azurerm_storage_account.example.name
#   storage_account_access_key = azurerm_storage_account.example.primary_access_key
#   site_config {}
#   app_settings = {
#     FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
#     APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.example.instrumentation_key
#     # This is required for https://github.com/Azure/webapps-deploy
#     WEBSITE_WEBDEPLOY_USE_SCM      = true
#   }
#   lifecycle {
#     ignore_changes = [
#       # Don't clear deployments
#       app_settings["WEBSITE_RUN_FROM_PACKAGE"],
#       app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"]
#     ]
#   }
# }

# Option 2 - deploy with the code

data "archive_file" "example" {
  type        = "zip"
  source_dir  = "${local.src_dir}/build/"
  output_path = "${local.root_dir}/zip/src.zip"
}

resource "terraform_data" "replacement_trigger" {
  input = data.archive_file.example.output_md5
}

# resource "azurerm_storage_blob" "example" {
#   name                   = local.prefix
#   storage_account_name   = azurerm_storage_account.example.name
#   storage_container_name = azurerm_storage_container.example.name
#   type                   = "Block"
#   source                 = data.archive_file.example.output_path
#   content_md5            = data.archive_file.example.output_md5
# }

resource "azurerm_windows_function_app" "example" {
  name                       = local.prefix
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  site_config {}
  zip_deploy_file = data.archive_file.example.output_path
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.example.instrumentation_key
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
    WEBSITE_RUN_FROM_PACKAGE       = 1
    # WEBSITE_RUN_FROM_PACKAGE = azurerm_storage_blob.example.url
  }
  lifecycle {
    ignore_changes = [
      app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"],
      site_config["application_insights_key"]
    ]
    replace_triggered_by = [terraform_data.replacement_trigger]
  }
}
