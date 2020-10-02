# locals {
#   eks_admin = [
#       userarn  = data.terraform_remote_state.main_vpc.outputs.eks-admin
#       username = var.eks-admin
#       groups   = ["system:masters"]
#   ],
  
#   eks_user = [
#       userarn  = data.terraform_remote_state.main_vpc.outputs.eks-user
#       username = var.eks-user
#       groups   = ["eks-user-group"]
#   ]
# }