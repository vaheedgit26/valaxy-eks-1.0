module "ecr" {
  source = "../../../modules/ecr"

  project = var.project  # "pharma"
  env     = var.env      # "dev"
  repositories = [
    "api-gateway",
    "auth-service",
    "pharma-ui",
    "notification-service",
    "drug-catalog-service"
  ]
}
