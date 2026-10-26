# Production Environment VPC Configuration
module "vpc" {
  source = "../../modules/vpc"

  environment          = "prod"
  vpc_cidr             = "10.30.0.0/16"
  public_subnet_cidrs  = ["10.30.1.0/24", "10.30.2.0/24"]
  private_subnet_cidrs = ["10.30.101.0/24", "10.30.102.0/24"]
}