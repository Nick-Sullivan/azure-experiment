
resource "azurerm_windows_function_app" "example" {
  name                       = local.prefix
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  # zip_deploy_file = data.archive_file.zip.output_path
  site_config {}
  # site_config {
  #   application_stack {
  #     dotnet_version="8.0"
  #     use_dotnet_isolated_runtime=true
  #   }
  # }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "dotnet-isolated"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.example.instrumentation_key
    WEBSITE_WEBDEPLOY_USE_SCM      = true
    # WEBSITE_RUN_FROM_PACKAGE       = 1
    # SCM_DO_BUILD_DURING_DEPLOYMENT = true  # true if zip_deploy_file is specified
  }

  lifecycle {
    ignore_changes = [
      # Don't clear deployments
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"]
    ]
  }
}
