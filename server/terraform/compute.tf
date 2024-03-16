resource "azurerm_service_plan" "example" {
  name                = local.prefix
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = "Windows"
  sku_name            = "Y1" # elastic
}
