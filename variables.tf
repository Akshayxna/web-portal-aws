variable "db_username" {
  description = "Database admin username"
  type        = string
  sensitive   = true
}

variable "db_pass" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}