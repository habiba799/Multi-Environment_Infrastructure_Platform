variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the ASG across multiple AZs"
}

variable "alb_security_group_id" {
  type        = string
  description = "Security group ID of the ALB to allow incoming traffic from load balancer"
}

variable "target_group_arn" {
  type        = string
  description = "Target group ARN to attach ASG instances"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "user_data" {
  type        = string
  description = "User data script to configure Nginx"
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 2
}

variable "desired_capacity" {
  type        = number
  default     = 2 # Keeps 2 instances running across 2 AZs
}