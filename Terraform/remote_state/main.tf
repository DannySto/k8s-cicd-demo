locals {
  lock_key = "LockID"
  common_tags = {
    Project = "demo-k8s-cicd"
  }
}

 
resource "aws_kms_key" "rs_kms_key" {
  description             = "Used to encrypt S3 remote state bucket"
  deletion_window_in_days = 10

  tags = merge(
    local.common_tags,
    map(
      "Name", "cicd-s3-remote-state"
    )
  )
}

resource "aws_kms_alias" "rs_kms_key_alias" {
  name          = "alias/remote_state_s3_key"
  target_key_id = aws_kms_key.rs_kms_key.key_id
}

resource "aws_s3_bucket" "rs_log" {
  bucket = var.log_bucket_name
  acl    = "log-delivery-write"

  tags = local.common_tags
}

resource "aws_s3_bucket" "rs_state" {
  bucket = var.rs_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.rs_log.id
    target_prefix = "log/"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "rs_state_block_public" {
  bucket = aws_s3_bucket.rs_state.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_public_access_block" "rs_log_block_public" {
  bucket = aws_s3_bucket.rs_log.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}


resource "aws_dynamodb_table" "tf_dynamodb_table" {
  name           = var.aws_dynamodb_table
  read_capacity  = 1
  write_capacity = 1
  hash_key       = local.lock_key

  attribute {
    name = local.lock_key
    type = "S"
  }

  tags = local.common_tags
}