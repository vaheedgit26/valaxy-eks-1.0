data "aws_caller_identity" "current" {}

module "iam" {
  source = "../../../modules/iam"

  project           = var.project                     # "pharma"
  env               = var.env                         # "dev"
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  aws_account_id    = data.aws_caller_identity.current.account_id
}
