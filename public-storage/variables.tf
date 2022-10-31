variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "name" {
  type = string
}

variable "allowed_origins" {
  type    = list(string)
  default = ["*"]
}

variable "allowed_headers" {
  type    = list(string)
  default = ["*"]
}

variable "tags" {
  type = map(any)
}
