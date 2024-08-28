variable "resource_group_location" { 
  type        = string 
  default     = "eastus" 
  description = "Location of the resource group." 
} 

variable "resource_group_name_prefix" { 
  type        = string 
  default     = "rg" 
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription." 
} 

variable "vm_size" { 
  type        = string 
  default     = "Standard_B1s" 
  description = "The size of the Virtual Machine." 
} 

variable "admin_username" { 
  type        = string 
  default     = "azureuser" 
  description = "Admin username for the Virtual Machine." 
} 

variable "ssh_public_key_path" { 
  type        = string 
  default     = "~/.ssh/id_rsa.pub" 
  description = "Path to the SSH public key to access the Virtual Machine." 
} 

variable "environment" { 
  type        = string 
  default     = "development" 
  description = "The environment in which the VM is deployed." 
}
