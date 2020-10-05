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

output "eks-demo-user" {
  description = "ARN of user with limited access to EKS cluster"
  value       = aws_iam_user.demo-user.arn
}

output "eks-dev-user" {
  description = "ARN of user with limited access to EKS cluster"
  value       = aws_iam_user.dev-user.arn
}

output "ecr-repo-url" {
  description = "The URL of of the private repository"
  value       = aws_ecr_repository.demo-repo.repository_url
}
