# https://developer.hashicorp.com/terraform/language/values/variables

variable "azure_rg_name" {
  type        = string
  description = "The Azure RG Name"
  default     = "tw-prod-rg"
}

variable "azure_location" {
  type        = string
  description = "The Azure location"
  default     = "West Europe"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  default     = "twprodvnet"
}

variable "virtual_subnet1_name" {
  description = "Name of the Subnet 1"
  default     = "twsubnet1wprodvnet"
}

variable "public_ip_name" {
  description = "Name of the IP"
  default     = "twpip2023" #must be unique for Azure generally
}

variable "prefix" {
  type    = string
  default = "win-iis"
}

variable "network_security_group_name" {
  default = "twprodnsg"
}

variable "network_nic_name" {
  default = "twprodnic"
}

variable "vm_name" {
  default = "twprodnic"
}

