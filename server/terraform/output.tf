
# resource "terraform_data" "publish_profile" {
#   lifecycle {
#     replace_triggered_by = [azurerm_windows_function_app.example]
#   }

#   provisioner "local-exec" {
#     command = <<-EOT
#         az webapp deployment list-publishing-profiles \
#         -g ${azurerm_resource_group.example.name} \
#         -n ${azurerm_windows_function_app.example.name} \
#         --xml
#     EOT
#   }
# }

# output "azure_function_publish_profile" {
#   description = "Publish profile for deploying code to the Azure Function App."
#   value       = terraform_data.publish_profile.output
# }

# resource "local_sensitive_file" "publish_profile" {
#   content  = terraform_data.publish_profile.output
#   filename = "artifacts/publish_profile.xml"
# }

output "azure_resource_group_name" {
  description = "Name of the Azure Resource Group."
  value       = resource.azurerm_resource_group.example.name
}

output "azure_function_name" {
  description = "Name of the Azure Function App."
  value       = resource.azurerm_windows_function_app.example.name
}
