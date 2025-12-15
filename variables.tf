variable "identifier" {
  description = "The unique identifier for the database instance."
  type        = string
}

variable "instance_class" {
  description = "The instance class for the database instance (e.g. db.t3.micro)."
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage (in GB) to allocate."
  type        = number
}

variable "engine" {
  description = "The database engine to use (en. mysql, postgres)."
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
}

variable "username" {
  description = "The master username for the database."
  type        = string
  sensitive   = true
}

variable "password" {
  description = "The master password for the database. Must meet AWS requirements."
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "The name of the database subnet group to associate."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate."
  type        = list(string)
}

variable "storage_encrypted" {
  description = "Specifies whether the instance storage should be encrypted."
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Specifies whether the instance should be publicly accessible."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The number of days to retain automatic backups."
  type        = number
  default     = 7 # 7 días de retención
}

variable "skip_final_snapshot" {
  description = "Determines whether to skip creating a final snapshot when deleting the instance."
  type        = bool
  default     = false # Seguro por defecto
}

variable "multi_az" {
  description = "Specifies whether the database instance should be Multi-AZ."
  type        = bool
  default     = false # Default a Single-AZ por costos
}

variable "parameter_group_name" {
  description = "The name of the database parameter group to associate."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to apply to the resource."
  type        = map(string)
  default     = {}
}
