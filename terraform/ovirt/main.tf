provider "ovirt" {
  url = "${var.ovirt_url}"
  username  = "${var.ovirt_username}"
  password  = "${var.ovirt_password}"
}

terraform {
  backend "local" {
    path = "ovirt_terraform.tfstate"
  }
}

# Create VM call temp01
module "vm01" {
  source            = "../modules/vms"
  cluster_id        = "c5529b5d-1b4e-46e6-9cb1-5d44c28cd65b"
  vm_name           = "vm01"
  vm_hostname       = "vm01.finonex.com"
  vm_dns_servers    = "8.8.8.8"
  vm_dns_search     = "finonex.com"
  vm_memory         = "8096"
  vm_cpu_cores      = "8"
  vm_timezone       = "Europe/Sofia"
  vm_template_id    = "fd4b04a9-74b5-4287-adbc-3d5c6711d53f"
  vm_nic_device     = "eth0"
  vm_nic_ip_address = "172.20.120.28"
  vm_nic_gateway    = "172.20.120.254"
  vm_nic_netmask    = "255.255.255.0"