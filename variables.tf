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

variable "email_address" { 
  type        = string 
  description = "Email address to receive alerts." 
  default     = "your-email@example.com"  # Replace with a default email or leave as is for user to set 
}

variable "log_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "SKU for the Log Analytics Workspace."
}

variable "log_workspace_retention_days" {
  type        = number
  default     = 30
  description = "Retention period in days for the Log Analytics Workspace."
}

variable "diagnostic_log_retention_days" {
  type        = number
  default     = 7
  description = "Retention period in days for diagnostic logs."
}

variable "monitoring_agent_version" {
  type        = string
  default     = "9.10"
  description = "Version of the Dependency Agent for Azure Monitor."
}
