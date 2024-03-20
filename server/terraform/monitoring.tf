resource "azurerm_log_analytics_workspace" "example" {
  name                = local.prefix
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "example" {
  name                = local.prefix
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  workspace_id        = azurerm_log_analytics_workspace.example.id
  application_type    = "web"
}

# resource "azurerm_monitor_action_group" "example" {
#   name                = local.prefix
#   resource_group_name = azurerm_resource_group.example.name
#   short_name          = local.prefix_short
# }

# # Smart rules are automatically enabled, which prevents terraform from destroying it automatically.
# # We create the rule here instead.
# resource "azurerm_monitor_smart_detector_alert_rule" "example" {
#   name                = local.prefix
#   resource_group_name = azurerm_resource_group.example.name
#   detector_type       = "FailureAnomaliesDetector"
#   scope_resource_ids  = [azurerm_application_insights.example.id]
#   severity            = "Sev0"
#   frequency           = "PT1M"

#   action_group {
#     ids = [azurerm_monitor_action_group.example.id]
#   }

#   enabled = false
# }

# locals {
#   insight_types = toset([
#     "Slow page load time",
#     "Slow server response time",
#     "Long dependency duration",
#     "Degradation in server response time",
#     "Degradation in dependency duration",
#     "Degradation in trace severity ratio",
#     "Abnormal rise in exception volume",
#     "Potential memory leak detected",
#     "Potential security issue detected",
#     "Abnormal rise in daily data volume"
#   ])
# }
# resource "azurerm_application_insights_smart_detection_rule" "example" {
#   for_each                = local.insight_types
#   name                    = each.value
#   application_insights_id = azurerm_application_insights.example.id
#   enabled                 = false
# }