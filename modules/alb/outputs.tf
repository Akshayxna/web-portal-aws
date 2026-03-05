output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.portfolio-alb.dns_name
}

output "target_group_arn" {
  description = "the ArN odf the target group"
  value = aws_lb_target_group.Portfolio_tg.arn
}

output "alb_sg_id" {
    value = aws_security_group.alb_sg.id
}
