# 1. Security Group for EC2 Application Servers
resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for private app instances behind ALB"
  vpc_id      = var.vpc_id

  # Inbound Rule: Allow HTTP (Port 80) ONLY from the ALB Security Group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  # Outbound Rule: Allow all traffic out (so instances can use NAT Gateway for updates)
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

# 2. EC2 Launch Template (Blueprint for Auto Scaling)
resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false # Must be false because instances are in private subnets!
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Environment = var.environment
      Name        = "${var.environment}-private-app-server"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 3. Auto Scaling Group (Spanning across multiple private subnets in 2 AZs)
resource "aws_autoscaling_group" "app" {
  name_prefix         = "${var.environment}-asg-"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnet_ids # Takes the list of private subnets
  target_group_arns   = [var.target_group_arn]   # Automatically registers instances to ALB target group

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-private-app-server"
    propagate_at_launch = true
  }
}