# project, env and region extracted from S3 Bucket 
variable "region" {}          #  Actually for vpc creation, it takes region from provider block (For privider.tf) or from provider.tf
variable "project" {}
variable "env" {}

#############################################################################################################
variable "ami_id" {}
# variable "public_key_name" {}
variable "bastion_sg_id" { default = null }

variable "cluster_endpoint_public_access" {}
variable "cluster_endpoint_private_access" {}
#############################################################################################################

variable "db_password" {
  description = "Master password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret for the application"
  type        = string
  sensitive   = true
}
