# 1. DB Subnet Group spanning across Private Subnets
resource "aws_db_subnet_group" "main" {
  name        = "${var.environment}-db-subnet-group"
  subnet_ids  = var.private_subnet_ids
  description = "Database subnet group for private tiers"

  tags = {
    Name        = "${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}

# 2. RDS Security Group (Allows incoming traffic from EC2, but NO outbound traffic)
resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Security group for RDS database with zero egress"
  vpc_id      = var.vpc_id

  # Ingress: Allow MySQL traffic ONLY from EC2 Security Group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  # Egress: intentionally omitted or empty so RDS has zero outbound traffic flow

  tags = {
    Name        = "${var.environment}-rds-sg"
    Environment = var.environment
  }
}

# 3. RDS MySQL Instance
resource "aws_db_instance" "main" {
  identifier             = "${var.environment}-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name        = "${var.environment}-mysql-db"
    Environment = var.environment
  }
}