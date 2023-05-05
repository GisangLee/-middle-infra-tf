variable "ENV" {}
variable "AZ_LIST" {}
variable "DB_NAME" {}
variable "DB_USERNAME" {}
variable "DB_PWD" {}
variable "SUBNET_IDS" {}

resource "aws_rds_cluster" "toktokhan-test-rds" {
  cluster_identifier      = "toktokhan-test-${var.ENV}-rds-cluster"
  engine                  = "aurora-postgresql"
  availability_zones      = var.AZ_LIST
  database_name           = var.DB_NAME
  master_username         = var.DB_USERNAME
  master_password         = var.DB_PWD
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  scaling_configuration {
    min_capacity = 2
    max_capacity = 10
    auto_pause = true
    seconds_until_auto_pause = 300
    timeout_action = "ForceApplyCapacityChange"
  }
}

resource "aws_db_subnet_group" "toktokhan-test-rds-subnet-group" {
  name       = "toktokhan-test-${var.ENV}-rds-subnet-group"
  subnet_ids = var.SUBNET_IDS

  tags = {
    Iac = "Terraform"
    ENV = var.ENV
    Name = "toktokhan-test-${var.ENV}-rds-subnet-group"
  }
}