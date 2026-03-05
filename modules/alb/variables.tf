
variable "subnet_ids" {
  description = "List of Subnet IDs for the ALB"
  type        = list(string) 
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}