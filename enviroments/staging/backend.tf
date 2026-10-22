terraform {
  backend "s3" {
    bucket  = "terraform-project2-bucket" # Wahi same bootstrap bucket ka naam
    key     = "environments/staging/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform-dev"
  }
}