output "resource_group_name" { 
  description = "Resource group name." 
  value       = azurerm_resource_group.main_rg.name
} 

output "virtual_network_name" { 
  description = "Virtual network name." 
  value       = azurerm_virtual_network.primary_vnet.name
} 

output "subnet_name_1" { 
  description = "Subnet 1 name." 
  value       = azurerm_subnet.subnet_one.name
} 

output "subnet_name_2" { 
  description = "Subnet 2 name." 
  value       = azurerm_subnet.subnet_two.name 
} 

output "vm_name" { 
  description = "Virtual Machine name." 
  value       = azurerm_linux_virtual_machine.web_vm.name 
} 

output "vm_public_ip" { 
  description = "Public IP address of the Virtual Machine." 
  value       = azurerm_public_ip.vm_public_ip.ip_address 
} 

output "vm_private_ip" { 
  description = "Private IP address of the Virtual Machine." 
  value       = azurerm_network_interface.vm_nic.private_ip_address 
} 

output "admin_username" { 
  description = "Admin username for the Virtual Machine." 
  value       = var.admin_username 
}
