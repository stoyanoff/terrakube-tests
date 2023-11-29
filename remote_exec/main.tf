resource "null_resource" "remote_vm" {
    connection {
        type = "ssh"
        user = "${var.username}"
        private_key = "${file("${var.key_path}/${var.private_key_name}")}"
        # The connection will use the local SSH agent for authentication.
        agent = false
        timeout = "2m"
        host = "${var.vm_ip}"
    }

provisioner "remote-exec" {
    inline=[
      # INSTALL K3S
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=1.26.10+k3s2 INSTALL_K3S_EXEC= "--disable local-storage --disable servicelb --disable traefik"
      
      
       sh -",

    ]
}