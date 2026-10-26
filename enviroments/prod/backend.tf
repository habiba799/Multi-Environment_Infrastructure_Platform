terraform {
  backend "s3" {
    bucket  = "terraform-project2-bucket" # Wahi same bootstrap S3 bucket ka naam
    key     = "environments/prod/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform-dev"
  }
}