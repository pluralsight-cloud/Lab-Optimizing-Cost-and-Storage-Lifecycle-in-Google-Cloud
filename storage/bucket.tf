resource "google_storage_bucket" "reports_bucket" {
  # Stable bucket name (no random regeneration)
  name     = "nonprod-reporting-data-${var.project_id}"
  location = var.region

  # Initial (broken) state for lab
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  #########################################################
  #  SOLUTION – Lifecycle Cost Optimization
  #########################################################

  # -------------------------------------------------------
  # After 30 days → Move to NEARLINE
  # -------------------------------------------------------
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "NEARLINE"
  #   }
  #   condition {
  #     age = 30
  #   }
  # }

  # -------------------------------------------------------
  # After 90 days → Move to COLDLINE
  # -------------------------------------------------------
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "COLDLINE"
  #   }
  #   condition {
  #     age = 90
  #   }
  # }

  # -------------------------------------------------------
  # After 365 days → Move to ARCHIVE
  # -------------------------------------------------------
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "ARCHIVE"
  #   }
  #   condition {
  #     age = 365
  #   }
  # }

}

#########################################################
# Sample Object – Creates initial file for demonstration
#########################################################

resource "google_storage_bucket_object" "sample_report" {
  name   = "sample-report.txt"
  bucket = google_storage_bucket.reports_bucket.name

  content = "This is a sample report file for lifecycle demo."
}

