variable "name" {
  type = string
}

variable "vnet_cidr" {
  type = string
}

variable "bastion_subnet_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "application_subnet_cidr" {
  type = string
}

variable "trusted_subnet_cidr" {
  type = string
}

variable "database_subnet_cidr" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "tags" {
  type = map(any)
}
