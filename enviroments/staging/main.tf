# Staging Environment VPC Configuration
module "vpc" {
  source = "../../modules/vpc"

  environment         = "staging"
  vpc_cidr            = "10.20.0.0/16"
  public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnet_cidrs = ["10.20.101.0/24", "10.20.102.0/24"]
}