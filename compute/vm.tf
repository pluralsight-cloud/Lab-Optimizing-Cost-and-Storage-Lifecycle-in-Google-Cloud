# Non-production batch processing VM
# Executes a reporting job once per day

resource "google_compute_instance" "reporting_vm" {
  name = "reporting-vm"

  # ❌ PROBLEM:
  # n1-standard-8 is significantly over-provisioned
  # for a low-utilization, non-production workload.
  machine_type = "n1-standard-8"

  zone    = "us-central1-a"
  project = google_project.student_lab_project.project_id

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  labels = {
    env = "nonprod"
    app = "reporting"
  }

  # ❌ PROBLEM:
  # VM runs 24/7 even though workload is periodic.
  # Idle CPU = wasted cost.

  depends_on = [
    google_project_service.common_apis["compute.googleapis.com"]
  ]
}