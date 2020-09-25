# Common variables
variable "region" {
  type        = string
  description = "The region where to deploy terraform"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
}


# Remote state variables
variable "aws_dynamodb_table" {
  type        = string
  description = "Name of Dynamo DB table used to lock remote state"
}

variable "rs_bucket_name" {
  type        = string
  description = "Name of bucket where remote state is stored"
}

variable "log_bucket_name" {
  type        = string
  description = "Name of bucket where logs of remote state bucket are stored"
}


# VPC variables

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "eks_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "The private subnets for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets for the VPC"
}
