variable "project" {
  default = "minecraft-246610"
}

variable "name" {
  default = "minecraft-server"
}

variable "cpu_size" {
  default = "2"
}

variable "ram_size" {
  default = "2560"
}

variable "zone" {
  default = "europe-west2-c"
}

variable "image" {
  default = "ubuntu-1804-bionic-v20190722a"
}

variable "network" {
  default = "default"
}

variable "ssh_user" {
  default = "minecraft"
}

variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}

variable "scripts" {
  default = ["scripts/install.sh"]
}

variable "mods_file_source" {
  default = "files/mods"
}

variable "mods_file_destination" {
  default = "/home/minecraft/minecraft-server/mods/"
}

variable "service_file_source" {
  default = "files/minecraft.service"
}

variable "service_file_destination" {
  default = "/home/minecraft/minecraft.service"
}


variable "allowed_ports" {
  default = ["25565"]
}