# Retrieve data from remote state for VPC
data "terraform_remote_state" "main_vpc" {
  backend = "s3"
  config = {
    bucket = "tf-cicd-demo-remote-state"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
  }
}

data "aws_caller_identity" "current" {}

module "eks" {
  source          = "../modules/eks"
  cluster_name    = var.eks_name
  cluster_version = "1.17"
  subnets         = data.terraform_remote_state.main_vpc.outputs.private_subnets
  vpc_id          = data.terraform_remote_state.main_vpc.outputs.vpc_id

#  map_users = concat(local.admin_user_map_users, local.developer_user_map_users)
   map_users = [
      {
        userarn = "${data.terraform_remote_state.main_vpc.outputs.eks-admin}"
        username = "${var.eks-admin}"
        groups = ["system:masters"]
      },
      {
        userarn = "${data.terraform_remote_state.main_vpc.outputs.eks-user}"
        username = "${var.eks-user}"
        groups = ["eks-user-group"]
      },
    ]
    
  worker_groups = [
    {
      instance_type = "t3.small"
      asg_max_size  = 2
      asg_min_size  = 1
      asg_desired_capacity = 2
    }
  ]
}



data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}



  
