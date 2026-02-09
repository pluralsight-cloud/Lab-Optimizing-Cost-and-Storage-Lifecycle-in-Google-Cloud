resource "google_storage_bucket" "reports_bucket" {
  # Stable bucket name (no random regeneration)
  name     = "nonprod-reporting-data-${var.project_id}"
  location = var.region

  # Initial (broken) state for lab
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

#########################################################
# Sample Object – Creates initial file for demonstration
#########################################################

resource "google_storage_bucket_object" "sample_report" {
  name   = "sample-report.txt"
  bucket = google_storage_bucket.reports_bucket.name

  content = "This is a sample report file for lifecycle demo."
}

