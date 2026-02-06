resource "google_compute_instance" "reporting_vm" {
  name         = "reporting-vm"
  machine_type = "e2-standard-2"  # broken VM
  zone         = "${var.region}-a"  # use region variable
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  labels = {
    env = "nonprod"
    app = "reporting"
  }
}