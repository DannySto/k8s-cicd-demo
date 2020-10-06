# Retrieve data from remote state for VPC
data "terraform_remote_state" "main_vpc" {
  backend = "s3"
  config = {
    bucket = "tf-cicd-demo-remote-state"
    key    = "vpc/terraform.tfstate"
    region = "eu-north-1"
  }
}

module "eks" {
  source          = "../modules/eks"
  cluster_name    = var.eks_name
  cluster_version = "1.17"
  subnets         = data.terraform_remote_state.main_vpc.outputs.private_subnets
  vpc_id          = data.terraform_remote_state.main_vpc.outputs.vpc_id

  map_users = [
    {
      userarn  = "${data.terraform_remote_state.main_vpc.outputs.eks-admin}"
      username = "${var.eks-admin}"
      groups   = ["system:masters"]
    },
    {
      userarn  = "${data.terraform_remote_state.main_vpc.outputs.eks-demo-user}"
      username = "${var.demo-user}"
      groups   = ["eks-demo-group"]
    },
    {
      userarn  = "${data.terraform_remote_state.main_vpc.outputs.eks-dev-user}"
      username = "${var.dev-user}"
      groups   = ["eks-dev-group"]
    },
  ]

  worker_groups = [
    {
      instance_type        = "t3.small"
      asg_max_size         = 4
      asg_min_size         = 2
      asg_desired_capacity = 3
    }
  ]
}

# install istio
resource "null_resource" "istio" {
  provisioner "local-exec" {
    command = "istioctl install -f ./istio-profile.yml"
  }
  depends_on = [
    module.eks,
  ]
}








