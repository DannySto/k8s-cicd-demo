#/bin/bash
function pause(){
   read -p "$*"
}

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

pwd=$(pwd)

echo -e ${RED}"Check before flight!!!"${NC}
echo -e "You current directory --> "  ${GREEN} $pwd ${NC}
echo -e "${RED}Going to delete var.tf from local directory and copy var.tf from main var directory (~/vars/var.tf)${NC}"
pause 'Press [Enter] key to continue...'

mkdir -p archive
mv ./var.tf archive/var.tf.$(date +%s).bak
ln -s /home/ec2-user/environment/k8s-cicd-demo/Terraform/variables/var.tf ./var.tf


terraform plan -out plan.tfplan -var-file=/home/ec2-user/environment/k8s-cicd-demo/Terraform/variables/var.tfvars
