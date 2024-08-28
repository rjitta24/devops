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

# Create a Public IP Address for the VM 
resource "azurerm_public_ip" "vm_public_ip" { 
  name                = "${random_pet.prefix.id}-public-ip" 
  location            = azurerm_resource_group.main_rg.location 
  resource_group_name = azurerm_resource_group.main_rg.name 
  allocation_method   = "Dynamic" 
} 

# Create a Network Security Group (NSG)
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${random_pet.prefix.id}-nsg"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create a Network Interface for the VM 
resource "azurerm_network_interface" "vm_nic" { 
  name                = "${random_pet.prefix.id}-nic" 
  location            = azurerm_resource_group.main_rg.location 
  resource_group_name = azurerm_resource_group.main_rg.name 

  ip_configuration { 
    name                          = "internal" 
    subnet_id                     = azurerm_subnet.subnet_one.id 
    private_ip_address_allocation = "Dynamic" 
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id 
  } 
}

# Associate the NSG with the Network Interface
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

# Create the Virtual Machine with Apache installed 
resource "azurerm_linux_virtual_machine" "web_vm" { 
  name                = "${random_pet.prefix.id}-vm" 
  location            = azurerm_resource_group.main_rg.location 
  resource_group_name = azurerm_resource_group.main_rg.name 
  network_interface_ids = [azurerm_network_interface.vm_nic.id] 
  size                = var.vm_size 

  os_disk { 
    caching              = "ReadWrite" 
    storage_account_type = "Standard_LRS" 
    name                 = "${random_pet.prefix.id}-osdisk" 
  } 

  source_image_reference { 
    publisher = "Canonical" 
    offer     = "UbuntuServer" 
    sku       = "18.04-LTS" 
    version   = "latest" 
  } 

  admin_username = var.admin_username 

  # You can use SSH key authentication or password authentication 
  admin_ssh_key { 
    username   = var.admin_username 
    public_key = file(var.ssh_public_key_path) 
  } 

  # Use a cloud-init script to install Apache 
  custom_data = <<-EOF 
              #!/bin/bash 
              sudo apt-get update -y 
              sudo apt-get install -y apache2 
              sudo systemctl enable apache2 
              sudo systemctl start apache2 
              EOF 

  tags = { 
    environment = var.environment 
  } 
}
