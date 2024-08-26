# Define the Resource Group 

resource "azurerm_resource_group" "main_rg" { 

  location = var.resource_group_location 

  name     = "${random_pet.prefix.id}-main-rg" 

} 

  

# Create the Virtual Network 

resource "azurerm_virtual_network" "primary_vnet" { 

  name                = "${random_pet.prefix.id}-primary-vnet" 

  address_space       = ["10.0.0.0/16"] 

  location            = azurerm_resource_group.main_rg.location 

  resource_group_name = azurerm_resource_group.main_rg.name 

} 

  

# Define Subnet 1 

resource "azurerm_subnet" "subnet_one" { 

  name                 = "subnet-one" 

  resource_group_name  = azurerm_resource_group.main_rg.name 

  virtual_network_name = azurerm_virtual_network.primary_vnet.name 

  address_prefixes     = ["10.0.0.0/24"] 

} 

  

# Define Subnet 2 

resource "azurerm_subnet" "subnet_two" { 

  name                 = "subnet-two" 

  resource_group_name  = azurerm_resource_group.main_rg.name 

  virtual_network_name = azurerm_virtual_network.primary_vnet.name 

  address_prefixes     = ["10.0.1.0/24"] 

} 

  

# Generate a Random Prefix 

resource "random_pet" "prefix" { 

  prefix = var.resource_group_name_prefix 

  length = 1 

} 
