output "resource_group_name" { 

  description = "Resource group name." 

  value = azurerm_resource_group.main_rg.name
 
} 

  

output "virtual_network_name" { 

  description = "Virtual network name." 

  value = azurerm_virtual_network.primary_vnet.name

} 

  

output "subnet_name_1" { 

  description = "Subnet 1 name." 

  value = azurerm_subnet.subnet_one.name

} 

  

output "subnet_name_2" { 

  description = "Subnet 2 name." 

  value = azurerm_subnet.subnet_two.name 

} 
