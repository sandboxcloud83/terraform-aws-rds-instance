# examples/main.tf

# ------------------------------------------------------------------------------
# 1. Preparación de Red (Usando Default VPC para simplificar el ejemplo)
# ------------------------------------------------------------------------------
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_subnet_group" "example" {
  name       = "example-rds-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "example-rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "example-rds-sg"
  description = "Allow MySQL traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Solo para ejemplo, en prod restringir
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ------------------------------------------------------------------------------
# 2. Gestión de Credenciales (Simulación de Secrets Manager)
# ------------------------------------------------------------------------------

# Generamos un password seguro aleatorio
resource "random_password" "master" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Creamos el secreto en AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_creds" {
  name_prefix = "example/rds-creds-"
  description = "Credenciales para el ejemplo de RDS"
  
  # Forzamos borrado inmediato para no dejar basura en la cuenta de pruebas
  recovery_window_in_days = 0 
}

# Guardamos el JSON con usuario y password en el secreto
resource "aws_secretsmanager_secret_version" "db_creds_val" {
  secret_id = aws_secretsmanager_secret.db_creds.id
  secret_string = jsonencode({
    username = "adminuser"
    password = random_password.master.result
  })
}

# ------------------------------------------------------------------------------
# 3. Llamada al Ladrillo (Módulo)
# ------------------------------------------------------------------------------

module "rds_instance" {
  source = ".." # Referencia al directorio padre

  identifier     = "example-db-instance"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  allocated_storage = 20
  
  # Pasamos el ARN del secreto que acabamos de crear
  db_credentials_secret_arn = aws_secretsmanager_secret.db_creds.arn

  db_subnet_group_name   = aws_db_subnet_group.example.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  # Opcionales para el test
  publicly_accessible     = false
  backup_retention_period = 1
  skip_final_snapshot     = true
}
