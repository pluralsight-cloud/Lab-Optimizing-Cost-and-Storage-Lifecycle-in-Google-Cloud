resource "random_id" "suffix" {
  byte_length = 4
}
resource "google_storage_bucket" "reports_bucket" {
  name     = "nonprod-reporting-data-${random_id.suffix.hex}"
  location = var.region
  storage_class = "STANDARD"  # broken configuration for the lab
  uniform_bucket_level_access = true

  # Uncomment to enable lifecycle cost optimization
  # -----------------------------------------
  # lifecycle_rule {
  #   action { type = "SetStorageClass"; storage_class = "NEARLINE" }
  #   condition { age = 30 }
  # }
  # lifecycle_rule {
  #   action { type = "SetStorageClass"; storage_class = "COLDLINE" }
  #   condition { age = 90 }
  # }
  # lifecycle_rule {
  #   action { type = "SetStorageClass"; storage_class = "ARCHIVE" }
  #   condition { age = 365 }
  # }
}

# Sample Object – Initialization
resource "google_storage_bucket_object" "sample_report" {
  name   = "sample-report.txt"
  bucket = google_storage_bucket.reports_bucket.name
  content = "This is a sample report file for lifecycle demo."
}
