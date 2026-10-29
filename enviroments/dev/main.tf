# 1. VPC Module Call
module "vpc" {
  source = "../../modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# 2. ALB Module Call
module "alb" {
  source = "../../modules/alb"

  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

# 3. EC2 / ASG Module Call (Creates its own security group internally)
module "ec2" {
  source = "../../modules/ec2"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  ami_id                = var.ami_id
  instance_type         = var.instance_type

  min_size         = 1
  max_size         = 3
  desired_capacity = 2 # Runs 2 instances across 2 AZs

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Private EC2 in Multi-AZ via ALB! 🚀</h1>" > /var/www/html/index.html
              EOF
}

# 4. RDS Module Call (Database Tier with zero egress, securely linked to EC2 SG)
module "rds" {
  source = "../../modules/rds"

  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  app_security_group_id = module.ec2.security_group_id
  
  instance_class        = "db.t3.micro"
  db_name               = "devdb"
  db_username           = "dbadmin"
  db_password           = "SuperSecretPassword123"
}