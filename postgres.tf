resource "aws_rds_cluster" "this" {
  count                               = var.enabled ? 1 : 0
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = !var.protect
  backup_retention_period             = var.backup_retention_period
  cluster_identifier_prefix           = "${local.cluster_identifier_prefix}-"
  copy_tags_to_snapshot               = true
  database_name                       = var.database_name
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.enable_default_cluster_parameter_group ? try(aws_rds_cluster_parameter_group.this[0].name, null) : var.db_cluster_parameter_group_name
  db_subnet_group_name                = aws_db_subnet_group.this[0].id
  deletion_protection                 = var.protect
  enable_global_write_forwarding      = var.enable_global_write_forwarding
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  enable_http_endpoint                = var.enable_http_endpoint
  engine                              = "aurora-postgresql"
  engine_mode                         = "provisioned"
  engine_version                      = var.engine_version
  final_snapshot_identifier           = var.final_snapshot_identifier != null ? var.final_snapshot_identifier : local.snapshot_timestamp
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  iam_roles                           = var.create_iam_role ? concat([aws_iam_role.this[0].arn], var.iam_roles) : var.iam_roles
  kms_key_id                          = var.create_kms ? module.kms[0].arn : var.kms_key_id
  master_username                     = var.master_username
  master_password                     = random_password.password[0].result
  network_type                        = var.network_type
  port                                = 5432
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  replication_source_identifier       = var.replication_source_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  snapshot_identifier                 = var.snapshot_identifier != null ? var.snapshot_identifier : local.db_snapshot_source
  source_region                       = var.source_region
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  tags                                = merge(local.tags, var.tags)
  vpc_security_group_ids              = [aws_security_group.pg[0].id]

  serverlessv2_scaling_configuration {
    max_capacity             = var.max_capacity # increment must be equal to 0.5
    min_capacity             = var.min_capacity # increment must be equal to 0.5.
    seconds_until_auto_pause = var.min_capacity != 0 ? null : var.seconds_until_auto_pause
  }

  lifecycle {
    ignore_changes = [
      availability_zones,
      final_snapshot_identifier,
      engine_version,
      cluster_identifier_prefix
    ]
  }
}

resource "aws_rds_cluster_instance" "this" {
  count                                 = var.enabled ? var.cluster_instance_count : 0
  apply_immediately                     = !var.protect
  auto_minor_version_upgrade            = var.auto_minor_version_upgrade
  cluster_identifier                    = aws_rds_cluster.this[0].id
  copy_tags_to_snapshot                 = true
  engine                                = aws_rds_cluster.this[0].engine
  engine_version                        = aws_rds_cluster.this[0].engine_version
  identifier_prefix                     = "${local.cluster_identifier_prefix}-"
  instance_class                        = "db.serverless"
  monitoring_role_arn                   = aws_iam_role.pg_enhanced_monitoring[0].arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  promotion_tier                        = var.promotion_tier
  publicly_accessible                   = var.publicly_accessible
  preferred_maintenance_window          = var.preferred_maintenance_window
  tags                                  = merge(local.tags, var.tags)
  lifecycle {
    ignore_changes = [
      engine_version,
      identifier_prefix
    ]
  }
}
