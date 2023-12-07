variable "vm_ip" {}
variable "username" {}
#variable "master_ip" {}
variable "password" {}
# variable "worker1_ip" {}
# variable "worker2_ip" {}
variable "token" {}
variable "tlssan" {}
# variable "nodetoken" {
#     type = string
# }
# variable "timezone" {}
# variable "new_hostname" {}
# variable "private_key_name" {
#   type        = string
#   description = "File path of private key."
#   default     = "id_rsa"
# }
# variable "key_path"{
#   type        = string
#   description = "Dir path of private key."
#   default     = "/home/stoyan/.ssh/it"
# }

resource "null_resource" "remote_vm" {
    connection {
        type = "ssh"
        user = "${var.username}"
        password = "${var.password}"
        # private_key = "${file("${var.key_path}/${var.private_key_name}")}"
        # # The connection will use the local SSH agent for authentication.
        agent = false
        timeout = "1m"
        host = "${var.vm_ip}"
    }

  provisioner "remote-exec" {
    # INSTALL K3S MASTER
    inline=[
"curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.27.7+k3s2 INSTALL_K3S_EXEC='--disable local-storage --disable servicelb --disable traefik --token=${var.token} --tls-san=${var.tlssan}' sh -s",
# "curl -sfL http://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN_FILE=/var/lib/rancher/k3s/server/node-token sh -s - --docker"
    ]
  }
}