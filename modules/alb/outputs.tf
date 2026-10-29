output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.app.arn
  description = "ARN of the Target Group for EC2 attachment"
}
output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}