############################################
# Cloud Storage – Reporting Data (Single Region)
# Non-Production Environment
############################################

# Random suffix to ensure global bucket name uniqueness
resource "random_id" "suffix" {
  byte_length = 4
}

# Reporting bucket
resource "google_storage_bucket" "reports_bucket" {
  # Unique bucket name
  name     = "nonprod-reporting-data-${random_id.suffix.hex}"

  # Single region for cost-effective lab
  location = "us-central1"

  ############################################
  # ❌ COST-INEFFICIENT CONFIGURATION
  ############################################

  # STANDARD storage is the most expensive tier
  # and is applied to all objects, regardless of age
  storage_class = "STANDARD"

  # Security best practice
  uniform_bucket_level_access = true

  ############################################
  # ✅ SOLUTION (SCAFFOLDED – COMMENTED)
  ############################################
  # Learners can uncomment these lifecycle rules
  # to see the cost optimization in action

  # ------------------------------------------
  # After 30 days: STANDARD → NEARLINE
  # ------------------------------------------
  # Suitable for data accessed less than once per month
  #
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "NEARLINE"
  #   }
  #   condition {
  #     age = 30
  #   }
  # }

  # ------------------------------------------
  # After 90 days: NEARLINE → COLDLINE
  # ------------------------------------------
  # For historical, infrequently accessed data
  #
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "COLDLINE"
  #   }
  #   condition {
  #     age = 90
  #   }
  # }

  # ------------------------------------------
  # After 365 days: COLDLINE → ARCHIVE
  # ------------------------------------------
  # Lowest-cost tier for long-term retention
  #
  # lifecycle_rule {
  #   action {
  #     type          = "SetStorageClass"
  #     storage_class = "ARCHIVE"
  #   }
  #   condition {
  #     age = 365
  #   }
  # }

  ############################################
  # Architectural takeaway:
  #
  # Lifecycle policies are preventative
  # cost controls — they reduce long-term
  # storage spend automatically and safely.
  ############################################
}
