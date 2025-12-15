resource "aws_db_instance" "this" {
  identifier     = var.identifier
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted

  username = var.username
  password = var.password

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible
  multi_az               = var.multi_az

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  apply_immediately       = false # No aplicar cambios inmediatamente (esperar ventana de mantenimiento)
  
  parameter_group_name = var.parameter_group_name
  
  tags = var.tags
}
