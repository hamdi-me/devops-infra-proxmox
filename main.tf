terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.21:8006/api2/json"
  pm_user    = "root@pam"
  pm_password = "hamdi2016@"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "dev_vm" {
  name        = "VM-clone"
  target_node = "pve"
  clone       = "nginx"

  cores       = 2
  sockets     = 1
  memory      = 1024
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    size    = "10G"
    type    = "scsi"
    storage = "local-lvm"
  }

  ipconfig0 = "ip=dhcp"

  ssh_user     = "ubuntu"
  ssh_private_key = file("C:/Users/hamdi/.ssh/id_ecdsa")

  ciuser = "ubuntu"
  cipassword = "ubuntu" # Tu peux l’enlever si tu utilises uniquement SSH

  os_type = "cloud-init"
}
