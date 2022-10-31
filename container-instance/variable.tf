variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
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

variable "app_profile_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "server" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}
