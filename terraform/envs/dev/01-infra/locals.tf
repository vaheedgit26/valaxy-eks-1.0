locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    Terraform   = "true"
  }
  eks_cluster_name = "${var.projrct}-${var.env}-eks-cluster"
}
