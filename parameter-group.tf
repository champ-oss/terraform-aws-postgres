# attach parameter group to cluster
resource "aws_rds_cluster_parameter_group" "this" {
  count       = var.enabled && var.enable_custom_cluster_parameter_group ? 1 : 0
  name_prefix = "${var.git}-cluster-pg"
  family      = "aurora-postgresql16"
  tags        = merge(local.tags, var.tags)

  parameter {
    name         = "aurora.logical_replication_globaldb"
    value        = "0" # Disabled
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "rds.logical_replication"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "aurora.logical_replication_backup"
    value        = "0" # Disabled
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "aurora.enhanced_logical_replication"
    value        = "1" # Enabled
    apply_method = "pending-reboot"
  }
}