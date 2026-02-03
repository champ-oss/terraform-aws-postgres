locals {
  snapshot_version_suffix = "-v${var.shared_snapshot_version}"

  max_snapshot_id_length = 63
  max_cluster_id_length  = local.max_snapshot_id_length - length(local.snapshot_version_suffix)

  # Guard against aws_rds_cluster being disabled (count = 0)
  snapshot_base = try(
    substr(
      aws_rds_cluster.this[0].id,
      0,
      local.max_cluster_id_length
    ),
    ""
  )
}

resource "aws_db_cluster_snapshot" "this" {
  count = var.enable_shared_snapshot && var.enabled ? 1 : 0

  db_cluster_identifier = aws_rds_cluster.this[0].id

  db_cluster_snapshot_identifier = var.db_cluster_snapshot_identifier != null
    ? var.db_cluster_snapshot_identifier
    : "${local.snapshot_base}${local.snapshot_version_suffix}"

  shared_accounts = var.shared_accounts_snapshot
  tags            = merge(local.tags, var.tags)
}

