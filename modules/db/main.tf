# Create DB subnet groups 

resource "aws_db_subnet_group" "db_subnet" {
  name       = "rds-subnetsg"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}


# Create DB security Group:

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allow MYSQL traffic from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = var.allowed_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
}

# Create RDS Cluster: ( Storage and Management Layer)

resource "aws_rds_cluster" "portfolio_aurora" {
  cluster_identifier      = "portfolio-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  database_name           = "portfolio_db"
  master_username         = var.db_username
  master_password         = var.db_pass
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  skip_final_snapshot     = true
}


# Create Cluster Instance 

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "portfolio-cluster-${count.index}"
  cluster_identifier = aws_rds_cluster.portfolio_aurora.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.portfolio_aurora.engine
  engine_version     = aws_rds_cluster.portfolio_aurora.engine_version
  publicly_accessible = false 

}


