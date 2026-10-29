output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The DNS name of the Application Load Balancer"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "asg_name" {
  value       = module.ec2.asg_name
  description = "The name of the Auto Scaling Group"
}

output "db_endpoint" {
  value       = module.rds.db_instance_endpoint
  sensitive   = true
  description = "The connection endpoint for the RDS MySQL database"
}