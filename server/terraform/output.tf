
output "azure_resource_group_name" {
  description = "Name of the Azure Resource Group."
  value       = resource.azurerm_resource_group.example.name
}

output "azure_function_name" {
  description = "Name of the Azure Function App."
  value       = resource.azurerm_windows_function_app.example.name
}
