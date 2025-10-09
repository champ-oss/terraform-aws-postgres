output "arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#arn"
  value       = var.enabled ? aws_rds_cluster.this[0].arn : ""
}

output "cluster_identifier" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_identifier"
  value       = var.enabled ? aws_rds_cluster.this[0].cluster_identifier : ""
}

output "cluster_resource_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_resource_id"
  value       = var.enabled ? aws_rds_cluster.this[0].cluster_resource_id : ""
}

output "cluster_members" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#cluster_members"
  value       = var.enabled ? aws_rds_cluster.this[0].cluster_members : []
}

output "database_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#database_name"
  value       = var.enabled ? aws_rds_cluster.this[0].database_name : ""
}

output "endpoint" {
  depends_on  = [aws_rds_cluster_instance.this]
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#endpoint"
  value       = var.enabled ? aws_rds_cluster.this[0].endpoint : ""
}

output "kms_key_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#key_id"
  value       = var.create_kms ? try(module.kms[0].arn, "") : try(var.kms_key_id, "")
}

output "master_username" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#master_username"
  value       = var.enabled ? aws_rds_cluster.this[0].master_username : ""
}

output "master_password" {
  description = "https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password"
  value       = var.enabled ? aws_rds_cluster.this[0].master_password : ""
  sensitive   = true
}

output "password_ssm_name" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter#name"
  value       = var.enabled ? aws_ssm_parameter.this[0].name : ""
}

output "port" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#port"
  value       = var.enabled ? aws_rds_cluster.this[0].port : ""
}

output "reader_endpoint" {
  depends_on  = [aws_rds_cluster_instance.this]
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#reader_endpoint"
  value       = var.enabled ? aws_rds_cluster.this[0].reader_endpoint : ""
}

output "security_group_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#id"
  value       = var.enabled ? aws_security_group.pg[0].id : ""
}

output "dms_endpoint_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  value       = var.enabled && var.create_dms_endpoint ? aws_dms_endpoint.this[0].endpoint_id : ""
}

output "dms_endpoint_arn" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint"
  value       = var.enabled && var.create_dms_endpoint ? aws_dms_endpoint.this[0].endpoint_arn : ""
}

