output "db_instance_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "The connection endpoint for the database"
}

output "db_instance_address" {
  value       = aws_db_instance.main.address
  description = "The hostname of the database"
}