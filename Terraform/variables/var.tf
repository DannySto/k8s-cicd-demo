# Common variables
variable "region" {
  type        = string
  description = "The region where to deploy terraform"
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

