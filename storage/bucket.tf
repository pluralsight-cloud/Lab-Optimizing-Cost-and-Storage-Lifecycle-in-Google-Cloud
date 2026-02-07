resource "random_id" "suffix" {
  byte_length = 4
}

resource "google_storage_bucket" "reports_bucket" {
  name     = "nonprod-reporting-data-${random_id.suffix.hex}"
  location = var.region
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  # Uncomment for solution
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
