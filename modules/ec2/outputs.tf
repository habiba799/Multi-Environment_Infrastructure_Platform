output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.app_server.id
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}