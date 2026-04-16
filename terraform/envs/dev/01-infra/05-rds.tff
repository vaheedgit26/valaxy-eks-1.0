module "rds" {
  source = "../../../modules/rds"

  project               = var.project  # "pharma"
  env                   = var.env      # "dev"
  subnet_ids            = module.vpc.database_subnet_ids       # (since vpc outputs as list, so [] not required)
  vpc_id                = module.vpc.vpc_id
  # eks_security_group_id = module.eks.cluster_security_group_id
  rds_allowed_security_group_ids = [module.eks.cluster_security_group_id, module.bastion_sg.sg_id]

  db_name               = "pharmadb"
  db_username           = "pharmaadmin"
  db_password           = var.db_password
}
