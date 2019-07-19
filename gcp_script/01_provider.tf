provider "google" {
  credentials = "${file("~/minecraft-246610-9450c619cc82.json")}"
  project     = "${var.project}"
  region      = "europe-west2"
}