variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "bastion_subnet_cidr" {
  type = string
}

variable "bastion_subnet_id" {
  type = string
}

variable "bastion_nsg_id" {
  type = string
}

variable "name" {
  type = string
}

variable "public_key" {
  type = string
}

variable "tags" {
  type = map(any)
}
