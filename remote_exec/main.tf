variable "vm_ip" {}
variable "username" {}
# variable "timezone" {}
# variable "new_hostname" {}
variable "private_key_name" {
  type        = string
  description = "File path of private key."
  default     = "id_rsa"
}
variable "key_path"{
  type        = string
  description = "Dir path of private key."
  default     = "/home/stoyan/.ssh/it"
}

resource "null_resource" "remote_vm" {
    connection {
        type = "ssh"
        user = "${var.username}"
        private_key = "${file("${var.key_path}/${var.private_key_name}")}"
        # The connection will use the local SSH agent for authentication.
        agent = false
        timeout = "1m"
        host = "${var.vm_ip}"
    }

provisioner "remote-exec" {
    # INSTALL K3S
    inline=[
"curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.27.7+k3s2 INSTALL_K3S_EXEC='--disable local-storage --disable servicelb --disable traefik --token=q1w2e3r4100@ --tls-san=ubuntu-test-stoyan.finonex.com' sh -"
    ]
    }
}