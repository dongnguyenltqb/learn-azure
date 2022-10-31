# output "db_host" {
#   value = module.db.db_host
# }

output "bastion-eip" {
  value = module.bastion-vm.bastion-eip
}

output "nat_ip" {
  value = module.network.nat_ip
}

output "bastion-username" {
  value = module.bastion-vm.bastion-username
}

output "registry_url" {
  value = module.acr.registry_url
}

output "registry_username" {
  value = nonsensitive(module.acr.registry_username)
}

output "registry_password" {
  value = nonsensitive(module.acr.registry_password)
}

output "web_ip" {
  value = module.container.web_ip
}

output "api_ip" {
  value = module.container.api_ip
}

output "backoffice_ip" {
  value = module.container.backoffice_ip
}

