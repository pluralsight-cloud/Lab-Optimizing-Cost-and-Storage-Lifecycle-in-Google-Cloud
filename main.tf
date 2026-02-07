module "storage" {
  source     = "./storage"
  project_id = var.project_id
  region     = var.region
}

module "compute" {
  source     = "./compute"
  project_id = var.project_id
  region     = var.region
}
