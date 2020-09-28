terraform {
  backend "s3" {
    bucket         = "tf-cicd-demo-remote-state"
    key            = "eks/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "tf-remote-state-lock"
  }
}
