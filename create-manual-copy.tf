resource "aws_db_cluster_snapshot_copy" "manual_copy" {
  count                                 = var.enabled && var.source_automated_snapshot_arn != null ? 1 : 0
  source_db_cluster_snapshot_identifier = var.source_automated_snapshot_arn
  target_db_cluster_snapshot_identifier = "manual-${replace(basename(var.source_automated_snapshot_arn), ":", "-")}"
  tags                                  = merge(local.tags, var.tags)
}
