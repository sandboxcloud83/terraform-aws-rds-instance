# examples/outputs.tf

output "rds_endpoint" {
  description = "El endpoint de conexión a la base de datos."
  value       = module.rds_instance.db_instance_address
}

output "secret_arn" {
  description = "El ARN del secreto donde se guardó el password (para consultarlo en consola)."
  value       = aws_secretsmanager_secret.db_creds.arn
}

output "connection_string_example" {
  description = "Comando de ejemplo para conectar (requiere cliente mysql)."
  value       = "mysql -h ${module.rds_instance.db_instance_address} -u adminuser -p"
}
