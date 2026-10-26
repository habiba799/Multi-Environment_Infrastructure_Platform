terraform {
  backend "s3" {
    bucket  = "terraform-project2-bucket"
    key     = "environments/dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform-dev"
  }
}