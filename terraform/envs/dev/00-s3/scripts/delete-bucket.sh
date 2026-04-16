###############################################################
# Usage: sh delete-s3-bucket.sh <project_name> <env> <region  #
###############################################################

#!/usr/bin/env bash
set -e

BUCKET=$(terraform -chdir=../../00-s3 output -raw bucket_id)              
ENV=$(terraform -chdir=../../00-s3 output -raw env)                       
REGION=$(terraform -chdir=../../00-s3 output -raw region)                 
PROJECT=$(terraform -chdir=../../00-s3 output -raw project)

echo """
📄 Details:
     PROJECT : ${PROJECT}
     ENV     : ${ENV}
     REGION  : ${REGION}
     BUCKET  : ${BUCKET}
"""
sleep 5

# PROJECT=$1
# ENV=$2
# REGION=$3

# terraform init

cd ..

terraform destroy \
  -var="project=$PROJECT" \
  -var="env=$ENV" \
  -var="region=$REGION"
  # -auto-approve


# terraform plan -destroy \
#  -var="project_name=expense" \
#  -var="env=dev" \
#  -var="region=ap-south-1" \
#  -out=destroy.tfplan

# terraform apply destroy.tfplan

####################################################################
# In VPC :: 
#   project_name
#   env
#   region
   
# In EKS ::
#   project
#   env
#   region
