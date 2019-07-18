resource "google_compute_firewall" "minecraft_firewall" {
  name          = "${var.name}-firewall"
  network       = "${var.network}"
  target_tags   = ["${var.name}"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = "${var.poolui_allowed_ports}"
  }
}