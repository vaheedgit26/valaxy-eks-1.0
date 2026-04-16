resource "aws_ec2_tag" "eks_subnet_tag_public_elb" {
  for_each    = var.eks_cluster_name != null ? toset(aws_subnet.public[*].id) : []
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "eks_subnet_tag_public_cluster" {
  for_each    = var.eks_cluster_name != null ? toset(aws_subnet.public[*].id) : []
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.eks_cluster_name}"
  value       = "owned"  # "shared"
}

resource "aws_ec2_tag" "eks_subnet_tag_private_elb" {
  for_each    = var.eks_cluster_name != null ? toset(aws_subnet.private[*].id) : []
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

resource "aws_ec2_tag" "eks_subnet_tag_private_cluster" {
  for_each    = var.eks_cluster_name != null ? toset(aws_subnet.private[*].id) : []
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.eks_cluster_name}"
  value       = "owned"   # "shared"
}
