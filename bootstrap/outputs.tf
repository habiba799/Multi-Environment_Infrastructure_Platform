output "s3_bucket_name" {
  value       = aws_s3_bucket.state_bucket.id
  description = "Name of the created remote state S3 bucket"
}