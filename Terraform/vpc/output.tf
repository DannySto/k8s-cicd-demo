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
