

# Virtual networks contain all of our resources, which provides extra control over who can access them
resource "azurerm_virtual_network" "example" {
  name                = local.prefix
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Virtual networks are segmented into multiple smaller subnets
resource "azurerm_subnet" "storage" {
  name                 = "${local.prefix}-Storage"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

# resource "azurerm_network_security_group" "example" {
#   name                = local.prefix
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }