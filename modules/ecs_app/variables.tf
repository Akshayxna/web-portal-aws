variable "vpc_id" {
    description = "to whihc vpc to attach "
    type = string
}

variable "subnet_ids" {
    description = "list of subnet ids"
    type = list(string)
}

variable "target_group_arn" {
    description = "The ARN of the target group"
    type = string
}

variable "container_image" {
    description = "The image of the container"
    type = string
}

variable "alb_sg_id" {
  description = "Security Group ID for the ALB"
  type        = string
}

variable "container_env_vars" {
  description = "Environment variables for the container"
  type        = map(string)
  default     = {}
}