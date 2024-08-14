# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "terrastatefilezidmer"
    key     = "dev.tfstate"
    region  = "us-east-1"
  }
}
