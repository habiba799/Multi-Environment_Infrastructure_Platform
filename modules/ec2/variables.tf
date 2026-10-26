variable "environment" {
  description = "Deployment environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group and EC2 instance will be created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be placed"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance" 
  type        = string
  default     = "ami-0c7217cdde317cfec" # Standard Amazon Linux 2023 (us-east-1)
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}