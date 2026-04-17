locals {
  common_tags = {
    Project     = var.project
    Environment = var.env
    Terraform   = "true"
  }
  eks_cluster_name = "${var.project}-${var.env}-eks-cluster"
  bastion_sg_id    = var.cluster_endpoint_public_access == false ? module.bastion_sg.sg_id : null
}
