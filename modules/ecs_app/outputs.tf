output "app_security_group_id" {
  description = "The ID of the Security Group used by the ECS App"
  value       = aws_security_group.app_sg.id
}