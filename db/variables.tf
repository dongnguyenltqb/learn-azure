variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "database_subnet_id" {
  type = string
}

variable "tags" {
  type = map(any)
}

