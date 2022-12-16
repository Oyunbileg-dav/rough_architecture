resource "aws_db_instance" "rds" {
  allocated_storage = var.allocated_storage
  engine_version    = var.engine_version
  multi_az          = false
  db_name           = var.db_name
  username          = var.rds_db_admin
  password          = var.rds_db_password
  instance_class    = var.instance_class
  engine            = var.db_engine
}
