provider "google" {
  credentials = "${file("~/minecraft-246610-5e7544762e23.json")}"
  project     = "${var.project}"
  region      = "europe-west2"
}