terraform {
  backend "s3" {
    bucket  = "terraform-v4-backend"
    key     = "terraform-v4-state-bucket.tfstate"
    region  = "us-east-1"
    encrypt = "true"
  }
}