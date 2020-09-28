#/bin/bash
function pause(){
   read -p "$*"
}

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}Going to delete var.tf from local directory and copy var.tf from main var directory (~/vars/var.tf)${NC}"
echo -e "${GREEN}A new S3 bucket for storing remote state and a DynamoDB table for state locking will be created. ${NC}"

pause 'Press [Enter] key to continue...'

mkdir -p archive
mv ./var.tf archive/var.tf.$(date +%s).bak
ln -s /home/ec2-user/environment/k8s-cicd-demo/Terraform/variables/var.tf ./var.tf


terraform apply -var-file=/home/ec2-user/environment/k8s-cicd-demo/Terraform/variables/var.tfvars
