terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = google_project.student_lab_project.project_id
  region  = "us-central1"
}