output "resource_group_name" { 

  description = "Resource group name." 

  value       = azurerm_resource_group.rg.name 

} 

  

output "virtual_network_name" { 

  description = "Virtual network name." 

  value       = azurerm_virtual_network.my_terraform_network.name 

} 

  

output "subnet_name_1" { 

  description = "Subnet 1 name." 

  value       = azurerm_subnet.my_terraform_subnet_1.name 

} 

  

output "subnet_name_2" { 

  description = "Subnet 2 name." 

  value       = azurerm_subnet.my_terraform_subnet_2.name 

} 
