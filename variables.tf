variable "allow_major_version_upgrade" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#allow_major_version_upgrade"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#auto_minor_version_upgrade"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#backup_retention_period"
  type        = number
  default     = 35
}

variable "cidr_blocks" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#cidr_blocks"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

variable "cluster_identifier_prefix" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_identifier_prefix"
  type        = string
  default     = "postgresdb-test"
}

variable "cluster_instance_count" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance"
  type        = number
  default     = 1
}

variable "create_kms" {
  description = "Create a KMS key for the database cluster"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#database_name"
  type        = string
  default     = "this"
}

variable "deletion_window_in_days" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#deletion_window_in_days"
  type        = number
  default     = 30
}

variable "enable_global_write_forwarding" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_global_write_forwarding"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#engine_version"
  type        = string
  default     = "16.8"
}

variable "final_snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#final_snapshot_identifier"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iam_database_authentication_enabled"
  default     = true
  type        = bool
}

variable "iam_roles" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#iam_roles"
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#kms_key_id"
  type        = string
  default     = null
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-postgres"
}

variable "master_username" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#master_username"
  type        = string
  default     = "root"
}

variable "min_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#min_capacity"
  type        = number
  default     = 0.5
}

variable "max_capacity" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#max_capacity"
  type        = number
  default     = 8 # each ACU corresponds to approximately 2 GiB of memory
}

variable "network_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#network_type"
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#performance_insights_enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#performance_insights_retention_period"
  type        = number
  default     = null
}

variable "preferred_backup_window" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#preferred_backup_window"
  type        = string
  default     = "06:00-06:30"
}

variable "preferred_maintenance_window" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#preferred_maintenance_window"
  default     = "sun:07:00-Sun:07:30"
  type        = string
}

variable "private_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group#subnet_ids"
  type        = list(string)
}

variable "protect" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#deletion_protection"
  default     = true
  type        = bool
}

variable "promotion_tier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#promotion_tier"
  type        = number
  default     = 2
}

variable "publicly_accessible" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#publicly_accessible"
  type        = bool
  default     = false
}

variable "replication_source_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier"
  type        = string
  default     = null
}

variable "shared_accounts" {
  description = "AWS accounts to share the RDS cluster"
  type        = list(string)
  default     = []
}

variable "snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#snapshot_identifier"
  type        = string
  default     = null
}

variable "source_region" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#source_region"
  type        = string
  default     = null
}

variable "source_security_group_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule#source_security_group_id"
  type        = string
  default     = ""
}

variable "storage_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#storage_type"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#storage_encrypted"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  type        = string
}

variable "create_dms_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  type        = bool
  default     = false
}

variable "dms_endpoint_type" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint#endpoint_type"
  type        = string
  default     = "target"
}

variable "dms_endpoint_read_only" {
  description = "Use reader database endpoint for DMS"
  type        = bool
  default     = false
}

variable "create_iam_role" {
  description = "Create an IAM role and attach to the RDS cluster"
  type        = bool
  default     = false
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "enable_source_security_group" {
  description = "Enable source security group"
  type        = bool
  default     = true
}

variable "shared_accounts_snapshot" {
  description = "AWS accounts to share the RDS cluster snapshot"
  type        = list(string)
  default     = []
}

variable "db_cluster_snapshot_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_snapshot#db_cluster_snapshot_identifier"
  type        = string
  default     = null
}

variable "seconds_until_auto_pause" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#seconds_until_auto_pause"
  type        = number
  default     = null
}

variable "enable_backup" {
  description = "Enable backup module"
  type        = bool
  default     = false
}

variable "enable_continuous_backup" {
  description = "Enable continuous backup of the S3 bucket"
  type        = bool
  default     = null
}

variable "backup_delete_after" {
  description = "Specifies the number of days after creation that backups are deleted"
  type        = number
  default     = 30
}

variable "backup_schedule" {
  description = "Specifies the schedule for creating backups"
  type        = string
  default     = "cron(0 6 * * ? *)"
}

variable "enable_shared_snapshot" {
  description = "Enable sharing of the snapshot"
  type        = bool
  default     = false
}

variable "db_cluster_instance_class" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#db_cluster_instance_class"
  type        = string
  default     = null
}

variable "monitoring_interval" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance#monitoring_interval"
  type        = number
  default     = 60
}

variable "enable_http_endpoint" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#enable_http_endpoint"
  type        = bool
  default     = true
}

variable "enable_custom_cluster_parameter_group" {
  description = "Enable creation of default cluster parameter group"
  type        = bool
  default     = false
}
