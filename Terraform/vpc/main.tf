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




# data "aws_availability_zones" "available" {}


# resource "aws_vpc" "eks_vpc" {
#   cidr_block = "10.100.0.0/16"

#   tags = merge(
#     local.common_tags,
#     map(
#     "Name", var.vpc_name,
#     "kubernetes.io/cluster/${var.eks_name}", "shared",  # Allow Kubernetes Cloud Controller Manager and LB to identify subnets
#     )
#   )
# }

# resource "aws_subnet" "public_subnets" {
#   count = 3

#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   cidr_block              = "10.100.${count.index}.0/24"
#   map_public_ip_on_launch = true
#   vpc_id                  = aws_vpc.eks_vpc.id

#   tags = merge(
#     local.common_tags,
#     map(
#     "Name", "${var.project_name}_pub_${count.index}",
#     "kubernetes.io/cluster/${var.eks_name}", "shared", 
#     )
#   )
# }

# resource "aws_internet_gateway" "vpc_ig" {
#   vpc_id = aws_vpc.eks_vpc.id

#   tags = merge(
#     local.common_tags,
#     map(
#     "Name", "${var.project_name}_ig",
#     "kubernetes.io/cluster/${var.eks_name}", "shared", 
#     )
#   )
# }

# resource "aws_route_table" "vpc-ig-rt" {
#   vpc_id = aws_vpc.eks_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.vpc_ig.id
#   }

#   tags = merge(
#     local.common_tags,
#     map(
#     "Name", "${var.project_name}_rt",
#     "kubernetes.io/cluster/${var.eks_name}", "shared", 
#     )
#   )
# }

# resource "aws_route_table_association" "vpc_rt_association" {
#   count = 3

#   subnet_id      = aws_subnet.public_subnets.*.id[count.index]
#   route_table_id = aws_route_table.vpc-ig-rt.id
# }