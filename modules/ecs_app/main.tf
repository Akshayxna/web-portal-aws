# Create IAM role

resource "aws_iam_role" "my_app_role" {
  name = "my_dockerapp_role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {   
            Action: "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
                Service = "ecs-tasks.amazonaws.com"
            },
            
            
      }
    ]
  })
}


# Creating policy attachement 

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.my_app_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# Creating the ecs cluster

resource "aws_ecs_cluster" "app_cluster" {
  name = "my-app-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# Creating the Container

resource "aws_ecs_task_definition" "myapp_task" {
  family = "service"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu       = "256"
  memory    = "512"
  container_definitions = jsonencode([
    {
      name      = "mydoc_app"
      image     = var.container_image
      
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
    
  ])

}

# Create ecs service

resource "aws_ecs_service" "app_serve" {
  name            = "app_serve"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.myapp_task.arn
  desired_count   = 2
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.subnet_ids
    security_groups = [aws_security_group.app_sg.id]
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "mydoc_app"
    container_port   = 80
  }

}



# Creating Docker security group

resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




