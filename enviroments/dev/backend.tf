terraform {
  backend "s3" {
    bucket = "terraform-project2-bucket" # Yahan apni bootstrap wali S3 bucket ka exact naam likhein
    key    = "environments/dev/terraform.tfstate"
    region = "us-east-1"
    profile = "terraform-dev"
  }
}