################################################
# Usage: bash create-infra.sh    #################
################################################
# This script takes 'bucket', 'env', region' and 'project' as inputs from previous '00-s3-create' calling module 

#!/usr/bin/env bash
set -e

BUCKET=$(terraform -chdir=../../00-s3 output -raw bucket_id)              
ENV=$(terraform -chdir=../../00-s3 output -raw env)                       
REGION=$(terraform -chdir=../../00-s3 output -raw region)                 
PROJECT=$(terraform -chdir=../../00-s3 output -raw project)

echo """
📄 Details:
     PROJECT  : ${PROJECT}
     ENV      : ${ENV}
     REGION   : ${REGION}
     BUCKET   : ${BUCKET}
"""

# Step 0: Go to repo root
# cd "$(dirname "$0")"

echo "====================="
echo " Step 1: Initialiaze "
echo "====================="
cd ..

terraform init -upgrade \
  -backend-config="bucket=${BUCKET}" \
  -backend-config="key=${PROJECT}/${ENV}/eks/terraform.tfstate" \
  -backend-config="region=${REGION}" \
  -backend-config="encrypt=true" \
  -backend-config="use_lockfile=true"

echo "==========================================="
echo " Step 2: Checking Configuration Validity ? "
echo "==========================================="
terraform validate

echo "==================================="
echo " Step 3: Generating Terraform plan "
echo "==================================="
# terraform plan
terraform plan \
  -var="project=$PROJECT" \
  -var="env=$ENV" \
  -var="region=$REGION" 
  #-out=eks.tfplan \
  
echo "================================="
echo " Step 4: Applying Terraform plan "
echo "================================="
terraform apply \
  -var="project=$PROJECT" \
  -var="env=$ENV" \
  -var="region=$REGION" 
    
# terraform apply infra.tfplan    # -auto-approve

##############################################################################
# In VPC :: 
#   project_name
#   env
#   region
   
# In EKS ::
#   project
#   env
#   region
