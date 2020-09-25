output "aws_dynamodb_table_name" {
  description = "Name of Dynamo DB table used to lock remote state"
  value       = aws_dynamodb_table.tf_dynamodb_table.name
}

output "aws_dynamodb_table_arn" {
  description = "Name of Dynamo DB table used to lock remote state"
  value       = aws_dynamodb_table.tf_dynamodb_table.arn
}

output "rs_bucket_name_name" {
  description = "Name of bucket where remote state is stored"
  value       = aws_s3_bucket.rs_state.id
}


output "rs_bucket_name_arn" {
  description = "ARN of bucket where remote state is stored"
  value       = aws_s3_bucket.rs_state.arn
}
