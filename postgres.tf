locals {
  normalized_snapshot_identifier = (
    can(startswith(var.snapshot_identifier, "arn:"))
    ? var.snapshot_identifier
    : null
  )
}

resource "aws_rds_cluster" "this" {
  count                               = var.enabled ? 1 : 0
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = !var.protect
  backup_retention_period             = var.backup_retention_period
  cluster_identifier_prefix           = "${local.cluster_identifier_prefix}-"
  copy_tags_to_snapshot               = true
  database_name                       = var.database_name
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.enable_custom_cluster_parameter_group ? aws_rds_cluster_parameter_group.this[0].name : null
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
  skip_final_snapshot                 = false
  snapshot_identifier                 = local.normalized_snapshot_identifier
  source_region                       = var.source_region
  storage_type                        = var.storage_type
  storage_encrypted                   = var.storage_encrypted
  tags                                = merge(local.tags, var.tags)
  vpc_security_group_ids              = [aws_security_group.pg[0].id]

  serverlessv2_scaling_configuration {
    max_capacity             = var.max_capacity
    min_capacity             = var.min_capacity
    seconds_until_auto_pause = var.min_capacity != 0 ? null : var.seconds_until_auto_pause
  }

  lifecycle {
    precondition {
      condition = (
        var.snapshot_identifier == null ||
        var.snapshot_identifier == "" ||
        (
          can(startswith(var.snapshot_identifier, "arn:")) &&
          var.protect == false &&
          var.skip_final_snapshot == false
        )
      )
      error_message = <<EOT
        Invalid snapshot restore configuration.

        Rules:

        - snapshot_identifier = null or ""
        → Create a new cluster or manage an existing one normally

        - snapshot_identifier = snapshot ARN
        → Restore from snapshot (requires protect = false and skip_final_snapshot = false)

        Important:
          - snapshot_identifier MUST be null or "" when protect = true
          - Snapshot restores are only allowed while protect = false

        Required restore workflow:

        1. Set protect = false and apply
        2. Set snapshot_identifier to the snapshot ARN
          - ensure skip_final_snapshot = false
          - apply
        3. Set snapshot_identifier = null (or "")
        4. Re-enable protect = true and apply

        This prevents accidental re-restores and allows password rotation after restore.
      EOT
    }

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
