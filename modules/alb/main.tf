# Create LoadBalancer 

resource "aws_lb" "portfolio-alb" {
  name                       = "portfolio-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = false


  tags = {
    Environment = "portfolio-alb"
  }
}

# Create TargetGroup

resource "aws_lb_target_group" "Portfolio_tg" {
  name     = "Portfolio-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"   # The page AWS will ping (index.html)
    interval            = 30    # How often to check (seconds)
    timeout             = 5     # How long to wait for a response
    healthy_threshold   = 2     # Successes needed to be "Healthy"
    unhealthy_threshold = 2     # Failures needed to be "Unhealthy"
    matcher             = "200" # The HTTP code that means "OK"
  }
}


# Create Listner 

resource "aws_lb_listener" "Port_listner" {
  load_balancer_arn = aws_lb.portfolio-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Portfolio_tg.arn
  }
}


# Create ALB security group:

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Anyone can visit the website
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

