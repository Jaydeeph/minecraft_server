resource "google_compute_instance" "minecraft_instance" {
  name = "${var.name}"
  machine_type = "custom-${var.cpu_size}-${var.ram_size}"
  zone         = "${var.zone}"
  tags         = ["${var.name}"]
  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }
  network_interface {
    network = "${var.network}"
    access_config {
      
    }
  }
  metadata = {
    sshKeys = "${var.ssh_user}:${file("${var.public_key}")}"
  }
  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    host        = "${google_compute_instance.minecraft_instance.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file("${var.private_key}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir minecraft-server", 
      "cd minecraft-server", 
      "mkdir mods"
    ]
  }

  provisioner "file" {
    source      = "${var.mods_file_source}"
    destination = "${var.mods_file_destination}"
  }

  provisioner "file" {
    source      = "${var.service_file_source}"
    destination = "${var.service_file_destination}"
  }

  provisioner "remote-exec" {
    scripts = "${var.scripts}"
  }
}
