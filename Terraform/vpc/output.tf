output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "The private subnets ids"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "The public subnets ids"
  value       = module.vpc.public_subnets
}


output "eks-admin" {
  description = "ARN of user to be used as EKS administrator"
  value       = aws_iam_user.eks-admin.arn
}

output "eks-user" {
  description = "ARN of user with limited access to EKS cluster"
  value       = aws_iam_user.eks-user.arn
}