variable "private_subnet_ids" {
    type = list(string)
  
}

variable "db_pass" {
    type = string
    sensitive = true
}


variable "db_username" {
    type = string
}

variable "allowed_security_groups" {
  description = "List of Security Group IDs allowed to access the DB"
  type        = list(string)
}

variable "vpc_id" {
    type = string
  
}
