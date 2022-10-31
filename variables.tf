variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "container_registry_name" {
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

variable "storage_account_name" {
  type = string
}

variable "database_subnet_cidr" {
  type = string
}

variable "app_profile_name" {
  type = string
}

variable "web_container_name" {
  type = string
}

variable "api_container_name" {
  type = string
}

variable "backoffice_container_name" {
  type = string
}


# variable "db_name" {
#   type = string
# }

# variable "db_username" {
#   type = string
# }

# variable "db_password" {
#   type = string
# }

variable "tags" {
  type = map(any)
}

