variable k3sversion {}
variable "master1_ip" {}
variable "username" {}
variable "password" {}
variable "sshkeyfile" {}
variable "master2_ip" {}
variable "master3_ip" {}
variable "tlssan" {}

resource "null_resource" "master1_ip" {
  connection {
    type        = "ssh"
    user        = var.username
    password    = var.password
    agent       = false
    timeout     = "1m"
    host        = var.master1_ip
  }

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} INSTALL_K3S_EXEC='--cluster-init --disable traefik  --disable local-storage --tls-san=${var.tlssan}' sh -s - server",
    ]
  }
}

resource "null_resource" "retrieve_token" {
  provisioner "local-exec" {
    command = "ssh ${var.username}@${var.master1_ip} -i ${var.sshkeyfile} sudo cat /var/lib/rancher/k3s/server/token > rem_token.txt || true"
  }
  
  depends_on = [null_resource.master1_ip]
}

resource "null_resource" "master2_ip" {
  connection {
    type        = "ssh"
    user        = var.username
    password    = var.password
    agent       = false
    timeout     = "1m"
    host        = var.master2_ip
  }

#   provisioner "remote-exec" {
#     inline = [
#       "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=${\"$token\"} K3S_URL=https://${var.master1_ip}:6443 sh -s - server --cluster-init --disable traefik --disable local-storage -tls-san=${var.tlssan}",
#     ]
#   }

#   depends_on = [null_resource.retrieve_token]
# }

provisioner "remote-exec" {
#   depends_on = [null_resource.retrieve_token]

  inline = [
    "token=$(sudo cat rem_token.txt)",
    "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=\"$token\" K3S_URL=https://${var.master1_ip}:6443 sh -s - server --cluster-init --disable traefik --disable local-storage -tls-san=${var.tlssan}",
  ]
}

}


resource "null_resource" "master3_ip" {
  connection {
    type        = "ssh"
    user        = var.username
    password    = var.password
    agent       = false
    timeout     = "1m"
    host        = var.master3_ip
  }

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=$(cat rem_token.txt) K3S_URL=https://${var.master1_ip}:6443 sh -s - server --cluster-init --disable traefik --disable local-storage -tls-san=${var.tlssan}",
    ]
  }

  depends_on = [null_resource.retrieve_token]
}

# resource "null_resource" "master2_ip" {
  
#   connection {
#       type = "ssh"
#       user = "${var.username}"
#       password = "${var.password}"
#       # private_key = "${file("${var.key_path}/${var.private_key_name}")}"
#       # # The connection will use the local SSH agent for authentication.
#       agent = false
#       timeout = "1m"
#       host = "${var.master2_ip}"

#   }

# #   provisioner "remote-exec" {
# #   # INSTALL K3S MASTER 2
# #     inline=[
# #       "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion}",
# #       "K3S_TOKEN='${data.local_file.token_file.content }'",
# #       "K3S_URL=https://${var.master1_ip}:6443 INSTALL_K3S_EXEC='server --cluster-init --disable traefik  --disable local-storage -tls-san=${var.tlssan}' sh -s",
# #       ]
# #   }
# #   depends_on = [null_resource.retrieve_token]
# #   #depends_on = [null_resource.master1_ip]
# # }
# provisioner "remote-exec" {
#     inline = [
#       #"export K3S_TOKEN=$(cat ${path.module}/remote_token.txt)",${data.local_file.token_file.content}
#       "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=${data.local_file.token_file.content} K3S_URL=https://${var.master1_ip}:6443 sh -s - server --cluster-init --disable traefik  --disable local-storage -tls-san=${var.tlssan}",
#       ]
#   }
#   depends_on = [null_resource.retrieve_token]
#   #depends_on = [null_resource.master1_ip]
# }

# resource "null_resource" "master3_ip" {

#   connection {
#       type = "ssh"
#       user = "${var.username}"
#       password = "${var.password}"
#       # private_key = "${file("${var.key_path}/${var.private_key_name}")}"
#       # # The connection will use the local SSH agent for authentication.
#       agent = false
#       timeout = "1m"
#       host = "${var.master3_ip}"
#   }

# #   provisioner "remote-exec" {
# #   # INSTALL K3S MASTER 2
# #     inline=[
# #       "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=${data.local_file.token_file.content} K3S_URL=https://${var.master1_ip}:6443 INSTALL_K3S_EXEC='server --cluster-init --disable traefik  --disable local-storage -tls-san=${var.tlssan}' sh -s",
# #       ]
# #   }
# #   depends_on = [null_resource.master2_ip]
# # }

# provisioner "remote-exec" {
#     inline = [
#       #"export K3S_TOKEN=$(cat ${path.module}/remote_token.txt)",
#       "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3sversion} K3S_TOKEN=${data.local_file.token_file.content} K3S_URL=https://${var.master1_ip}:6443 INSTALL_K3S_EXEC='server --cluster-init --disable traefik  --disable local-storage -tls-san=${var.tlssan}' sh -s",
# ]
#  }

#   depends_on = [null_resource.master2_ip]      
# }