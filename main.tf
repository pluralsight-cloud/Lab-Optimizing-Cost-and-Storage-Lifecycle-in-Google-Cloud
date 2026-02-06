# Root module
# Separates storage and compute to make cost auditing easier.

module "storage" {
  source = "./storage"
}

module "compute" {
  source = "./compute"
}