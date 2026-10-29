variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB will be created"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
}