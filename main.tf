module "vpc" {
  
    source = "./modules/vpc"

    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = [ "10.0.1.0/24", "10.0.2.0/24" ]  
    availability_zone = [ "ap-south-1a", "ap-south-1b" ]
}


module "alb" {
    source = "./modules/alb"

    subnet_ids = module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id

  
}

module "ecs_app" {
  source = "./modules/ecs_app"

  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  alb_sg_id         = module.alb.alb_sg_id
  target_group_arn  = module.alb.target_group_arn

  container_image   = "nginx:latest"
  container_env_vars = {
    TITLE = "My Terraform Project"
    BODY  = "This infrastructure was built using Terraform Modules, VPC, ALB, ECS Fargate, and RDS!"
  }
}


module "DB" {

    source = "./modules/db"

    private_subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
    db_pass = var.db_pass
    db_username = var.db_username
    allowed_security_groups = [module.ecs_app.app_security_group_id]

}


output "website_url" {
    value = module.alb.alb_dns_name
  
}