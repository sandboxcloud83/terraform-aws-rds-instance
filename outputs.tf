output "db_instance_arn" {
  description = "El ARN de la instancia de base de datos."
  value       = aws_db_instance.this.arn
}

output "db_instance_id" {
  description = "El ID de la instancia de base de datos."
  value       = aws_db_instance.this.id
}

output "db_instance_address" {
  description = "La dirección (endpoint) de la instancia de base de datos."
  value       = aws_db_instance.this.address
}

output "db_instance_port" {
  description = "El puerto de la instancia de base de datos."
  value       = aws_db_instance.this.port
}

output "db_instance_username" {
  description = "El nombre de usuario maestro de la instancia de base de datos."
  value       = aws_db_instance.this.username
  sensitive   = true
}
