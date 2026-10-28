# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for ${var.environment} EC2 instance"
  vpc_id      = var.vpc_id

  # Inbound Rule: Allow SSH (Port 22) for connection/troubleshooting
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Allow HTTP (Port 80) for web browser
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow all traffic to internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-ec2-sg"
    Environment = var.environment
  }
}

# EC2 Instance Creation
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  user_data_replace_on_change = true

  # Yeh raha User Data jo Nginx install karega
 user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Dev Environment Ubuntu EC2! Powered by Terraform 🚀</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "${var.environment}-app-server"
    Environment = var.environment
  }
}