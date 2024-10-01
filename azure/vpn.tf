
resource "azurerm_public_ip" "vpn_public_ip" {
  name                = "virtual_network_gateway_public_ip_1"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  # Public IP needs to be dynamic for the Virtual Network Gateway
  # Keep in mind that the IP address will be "dynamically generated" after
  # being attached to the Virtual Network Gateway below
  allocation_method = "Dynamic"
}

resource "azurerm_public_ip" "vpn_public_ip_backup" {
  name                = "virtual_network_gateway_public_ip_2"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  # Public IP needs to be dynamic for the Virtual Network Gateway
  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = "virtual_network_gateway"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  # Configuration for high availability
  active_active = true
  # This might me expensive, check the prices  
  sku = "VpnGw1"

  # Configuring the two previously created public IP Addresses
  ip_configuration {
    name                          = azurerm_public_ip.vpn_public_ip.name
    public_ip_address_id          = azurerm_public_ip.vpn_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_gateway.id
  }

  ip_configuration {
    name                          = azurerm_public_ip.vpn_public_ip_backup.name
    public_ip_address_id          = azurerm_public_ip.vpn_public_ip_backup.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet_gateway.id
  }
}

# Tunnel from Azure to AWS vpn_connection_1 (tunnel1)
resource "azurerm_local_network_gateway" "local_network_gateway_1_tunnel1" {
  name                = "local_network_gateway_1_tunnel1"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  # AWS VPN Connection public IP address
  gateway_address = var.aws_vpn_1_public_ip_1

  address_space = [
    # AWS VPC CIDR
    var.aws_vpc_cidr
  ]
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection_1_tunnel1" {
  name                = "virtual_network_gateway_connection_1_tunnel1"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway_1_tunnel1.id

  # AWS VPN Connection secret shared key
  shared_key = var.aws_vpn_1_shared_key_1
}

# Tunnel from Azure to AWS vpn_connection_1 (tunnel2)
resource "azurerm_local_network_gateway" "local_network_gateway_1_tunnel2" {
  name                = "local_network_gateway_1_tunnel2"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  gateway_address = var.aws_vpn_1_public_ip_2

  address_space = [
    var.aws_vpc_cidr
  ]
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection_1_tunnel2" {
  name                = "virtual_network_gateway_connection_1_tunnel2"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway_1_tunnel2.id

  shared_key = var.aws_vpn_1_shared_key_2
}

# Tunnel from Azure to AWS vpn_connection_2 (tunnel1)
resource "azurerm_local_network_gateway" "local_network_gateway_2_tunnel1" {
  name                = "local_network_gateway_2_tunnel1"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  gateway_address = var.aws_vpn_2_public_ip_1

  address_space = [
    var.aws_vpc_cidr
  ]
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection_2_tunnel1" {
  name                = "virtual_network_gateway_connection_2_tunnel1"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway_2_tunnel1.id

  shared_key = var.aws_vpn_2_shared_key_1
}

# Tunnel from Azure to AWS vpn_connection_2 (tunnel2)
resource "azurerm_local_network_gateway" "local_network_gateway_2_tunnel2" {
  name                = "local_network_gateway_2_tunnel2"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  gateway_address = var.aws_vpn_2_public_ip_2

  address_space = [
    var.aws_vpc_cidr
  ]
}

resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection_2_tunnel2" {
  name                = "virtual_network_gateway_connection_2_tunnel2"
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.virtual_network_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.local_network_gateway_2_tunnel2.id

  shared_key = var.aws_vpn_2_shared_key_2
}
