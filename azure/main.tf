resource "azurerm_resource_group" "application_rg" {
  name     = "application_rg"
  location = "East US"
}

resource "azurerm_virtual_network" "application_vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name
  address_space       = ["10.0.0.0/16"]
}

# The subnet where the Virtual Machine will live
resource "azurerm_subnet" "application_subnet" {
  name                 = "application_subnet"
  resource_group_name  = azurerm_resource_group.application_rg.name
  virtual_network_name = azurerm_virtual_network.application_vnet.name
  address_prefixes       = ["10.0.1.0/24"]
}

# The subnet where the VPN tunnel will live
resource "azurerm_subnet" "subnet_gateway" {
  # The name "GatewaySubnet" is mandatory
  # Only one "GatewaySubnet" is allowed per vNet
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.application_rg.name
  virtual_network_name = azurerm_virtual_network.application_vnet.name
  address_prefixes       = ["10.0.2.0/24"]
}
