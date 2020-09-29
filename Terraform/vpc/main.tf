locals {
  common_tags = {
    Project = var.project_name
  }
}

data "aws_availability_zones" "available" {}




module "vpc" {
  source  = "../modules/vpc"
 

  name = "${var.project_name}_vpc"
  cidr = var.cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  reuse_nat_ips        = false
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = merge(
    local.common_tags,
    map(
      "Name", var.vpc_name,
      "kubernetes.io/cluster/${var.eks_name}", "shared",
    )
  )

  public_subnet_tags = {
    "Name"                                  = "${var.project_name}-public"
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/elb"                = "1"
  }

  private_subnet_tags = {
    "Name"                                  = "${var.project_name}-private"
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"       = "1"
  }

  igw_tags = {
    "Name" = "${var.project_name}-IGW"
  }

}

# resource "aws_route53_zone" "public" {
#   name = "alexaki.org"

#   vpc {
#     vpc_id =  module.vpc.vpc_id
#   }
#     tags = local.common_tags
#   }

resource "aws_key_pair" "lefteris" {
  key_name   = "lefteris-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqLxdoCIibszsQ14whkFIC9OhCdqravjP1t9x5QNJf2mp1mDBkWplfQPXztiRhaDCBHvE6SVK1lZK/HkIVUn015vLVF2fiypFim7OQaJotbu+T1eRnZgY51Vdyur8iikA2dU5cSWa2+hVZ1w/0vodvcJhkvNNT2cz4FxFDQMup2oD9kVayEXkT0vNqhmgjguMAg8KVGeyYdbtouZupsisBHMNbYX5YUv5pCk/lKwT4YPfUPi8k9hzhor4/yauIKrtksES7g7pGPJGVvarAody+fZ8VPHjB/gut3My7jxP7hHaN8DH00mgluZW/ORj65jEpUNRhdOhSe2xHygkyUxyP lefteris"
}

