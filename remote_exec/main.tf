variable "vm_ip" {}
variable "username" {}
#variable "master_ip" {}
#  variable "password" {}
# variable "worker1_ip" {}
# variable "worker2_ip" {}
variable "token" {}
variable "tlssan" {}
# variable "nodetoken" {
#     type = string
# }
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

# resource "null_resource" remoteExecProvisionerFolder {

#   provisioner "file" {
#     source      = "test.txt"
#     destination = "/tmp/test.txt"
#   }

#   connection {
#     type     = "ssh"
#     host     = "${var.vm_ip}"
#     user     = "${var.username}"
#     password = "${var.admin_password}"
#   }
# }

# resource "null_resource" "AllInOne" {
#     connection {
#       type     = "ssh"
#       host     = "${var.vm_ip}"
#       user     = "${var.username}"
#       password = "${var.password}"
#     }

#     provisioner "remote-exec" {
#       inline=[
#         "if command -v docker &> /dev/null", 
#           "then sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin docker-ce-cli docker-ce-rootless-extras docker-compose",
#         "fi",
#         "sud export DEBIAN_FRONTEND=noninteractive",
#         "sudo curl https://releases.rancher.com/install-docker/20.10.sh | sudo sh",

#         "sudo apt install docker-compose -y",

#         "cd /tmp",
#         "sudo git clone https://github.com/its-knowledge-sharing/K3S-Demo.git",
#         "cd K3S-Demo",
#         "sudo ./start.bash",
#         "sudo mkdir -p /etc/rancher/k3s",
#         "sudo cp kubeconfig.yaml /etc/rancher/k3s/k3s.yaml",
#         "sudo sed -i '1s/^/export KUBECONFIG=/etc/rancher/k3s/k3s.yaml /' /root/.bash_profile",

#         "cd /tmp",
#         "sudo curl -LO 'https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'",
#         "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl"



#       ]
#     }
# }

# resource "null_resource" "RemoveAnyDocker" {
#     connection {
#       type     = "ssh"
#       host     = "${var.vm_ip}"
#       user     = "${var.username}"
#       password = "${var.admin_password}"
#     }

#     provisioner "remote-exec" {
#       inline=[
#         "if command -v docker &> /dev/null
#           then sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin
#         fi"
#       ]
#     }
# }


# resource "null_resource" "InstallRancherDocker" {
#   connection {
#     type     = "ssh"
#     host     = "${var.vm_ip}"
#     user     = "${var.username}"
#     password = "${var.admin_password}"
#   }

#   provisioner "remote-exec" {
#     inline=[
#       "curl https://releases.rancher.com/install-docker/20.10.sh | sudo sh"
#     ]
#   }
# }

# resource "null_resource" "InstallDockerCompose" {
#   connection {
#     type     = "ssh"
#     host     = "${var.vm_ip}"
#     user     = "${var.username}"
#     password = "${var.admin_password}"
#   }

#   provisioner "remote-exec" {
#     inline=[
#       "sudo apt install docker-compose -y"
#     ]
#   }
# }

# resource "null_resource" "GetRepo" {
#   connection {
#     type     = "ssh"
#     host     = "${var.vm_ip}"
#     user     = "${var.username}"
#     password = "${var.admin_password}"
#   }

#   provisioner "remote-exec" {
#     inline=[
#       "cd /tmp"
#       "sudo git clone https://github.com/its-knowledge-sharing/K3S-Demo.git"
#       "cd K3S-Demo"
#       "./start.bash"
#     ]
#   }
# }

# resource "null_resource" "copy-test-file" {

#   connection {
#     type     = "ssh"
#     host     = "${var.vm_ip}"
#     user     = "${var.username}"
#     password = "${var.admin_password}"
#   }

#   provisioner "file" {
#     source      = "test.txt"
#     destination = "/tmp/test.txt"
#   }
# }    




# data "external" "remote_file" {
#   program = ["bash", "${path.module}/get_remote_value.sh"]
# }

# variable "remote_value" {
#   default = data.external.remote_file.result
# }

# provisioner "remote-exec" {
#     # INSTALL K3S
#     inline=[
# "curl -sfL http://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN_FILE=/var/lib/rancher/k3s/server/node-token sh -s - --docker"
#     ]
# }

# }