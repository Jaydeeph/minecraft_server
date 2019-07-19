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
  default = "ubuntu-minimal-1804-bionic-v20190628"
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
  default = ["minecraft_script.sh"]
}

variable "allowed_ports" {
  default = ["25565"]
}