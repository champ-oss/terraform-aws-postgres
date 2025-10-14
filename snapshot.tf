resource "aws_db_cluster_snapshot" "this" {
  count                          = var.enabled && var.enable_manual_cluster_snapshot ? 1 : 0
  db_cluster_identifier          = try(aws_rds_cluster.this[0].id, null)
  db_cluster_snapshot_identifier = "${local.cluster_identifier_prefix}-snapshot-${local.snapshot_timestamp}"

  tags = merge(
    local.tags,
    {
      Name = "${local.cluster_identifier_prefix}-snapshot-${local.snapshot_timestamp}"
    },
    var.tags,
  )
}
