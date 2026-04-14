###########################################################
# Usage: bash delete-infra.sh <project_name> <env> <region> #
###########################################################
# <project_name> <env> <region>
#!/usr/bin/env bash
set -e

BUCKET=$(terraform -chdir=../../00-s3-create output -raw bucket_id)              
ENV=$(terraform -chdir=../../00-s3-create output -raw env)                       
REGION=$(terraform -chdir=../../00-s3-create output -raw region)                 
PROJECT=$(terraform -chdir=../../00-s3-create output -raw project)

echo """
📄 Details:
     PROJECT : ${PROJECT}
     ENV     : ${ENV}
     REGION  : ${REGION}
     BUCKET  : ${BUCKET}
"""

# terraform init

cd ..

terraform destroy \
  -var="project=$PROJECT" \
  -var="env=$ENV" \
  -var="region=$REGION" 
  
  #-var="s3_bucket_id=$BUCKET"
  # -auto-approve


# terraform plan -destroy \
#  -var="project_name=expense" \
#  -var="env=dev" \
#  -var="region=ap-south-1" \
#  -out=destroy.tfplan

# terraform apply destroy.tfplan

##############################################################################
# In VPC :: 
#   project_name
#   env
#   region
   
# In EKS ::
#   project
#   env
#   region
