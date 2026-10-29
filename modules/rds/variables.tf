variable "environment" { 
  type = string 
}

variable "vpc_id" { 
  type = string 
}

variable "private_subnet_ids" { 
  type = list(string) 
}

variable "app_security_group_id" { 
  type = string 
}

variable "instance_class" { 
  type    = string 
  default = "db.t3.micro" 
}

variable "db_name" { 
  type    = string 
  default = "appdb" 
}

variable "db_username" { 
  type    = string 
  default = "adminuser" 
}

variable "db_password" { 
  type      = string 
  sensitive = true 
}