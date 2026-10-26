# Dev Environment VPC Configuration
module "vpc" {
  source = "../../modules/vpc"

  environment          = "dev"
  vpc_cidr             = "10.10.0.0/16"
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = ["10.10.101.0/24", "10.10.102.0/24"]
}
# Dev Environment EC2 Instance (Placed in the first public subnet for now)
module "ec2" {
  source = "../../modules/ec2"

  environment   = "dev"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0] # Pehle public subnet mein server banega
  instance_type = "t2.micro"
}