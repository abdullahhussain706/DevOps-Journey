
# ==========================================
# Resource Group
# ==========================================

resource "azurerm_resource_group" "main" {
  name     = "vm-test_group"
  location = "centralindia"

  lifecycle {
    prevent_destroy = true
  }
}


# ==========================================
# Virtual Network
# ==========================================

resource "azurerm_virtual_network" "main" {
  name                = "vm-test-vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.1.0.0/16"]

  lifecycle {
    prevent_destroy = true
  }
}


# ==========================================
# Subnet
# ==========================================

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.1.1.0/24"]

  default_outbound_access_enabled               = false
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
}


# ==========================================
# Network Security Group
# ==========================================

resource "azurerm_network_security_group" "main" {
  name                = "vm-test-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Frontend-8080"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}


# ==========================================
# VM Public IP
# ==========================================

resource "azurerm_public_ip" "vm" {
  name                = "vm-test-publicip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  allocation_method       = "Static"
  sku                     = "Standard"
  sku_tier                = "Regional"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4
}


# ==========================================
# NAT Public IP
# ==========================================

resource "azurerm_public_ip" "nat" {
  name                = "nat-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  allocation_method       = "Static"
  sku                     = "StandardV2"
  sku_tier                = "Regional"
  ip_version              = "IPv4"
  idle_timeout_in_minutes = 4
}


# ==========================================
# NAT Gateway
# ==========================================

resource "azurerm_nat_gateway" "main" {
  name                = "my-secure-nat-gw"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku_name                = "StandardV2"
  idle_timeout_in_minutes = 4
}


# ==========================================
# NAT Gateway Associations
# ==========================================

resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "main" {
  subnet_id      = azurerm_subnet.default.id
  nat_gateway_id = azurerm_nat_gateway.main.id
}


# ==========================================
# Network Interface
# ==========================================

resource "azurerm_network_interface" "main" {
  name                = "vm-test121"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfig1"
    primary                       = true
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}


# ==========================================
# NIC - NSG Association
# ==========================================

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}


# ==========================================
# SSH Public Key
# ==========================================

resource "azurerm_ssh_public_key" "main" {
  name                = "vm-test"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkXAOIYwW/MTyocEbzzn+CM7U0cqyAiLs5wwLRPtUk0 generated-by-azure"
}


# ==========================================
# VM Extension
# ==========================================

resource "azurerm_virtual_machine_extension" "vm_access" {
  name                 = "enablevmAccess"
  virtual_machine_id   = "/subscriptions/47a101fc-61cb-4415-b7ac-4e768ff2be2e/resourceGroups/VM-TEST_GROUP/providers/Microsoft.Compute/virtualMachines/vm-test"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "VMAccessForLinux"
  type_handler_version = "1.5"

  auto_upgrade_minor_version = true
}
