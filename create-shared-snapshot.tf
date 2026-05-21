resource "aws_db_cluster_snapshot" "this" {
  count                 = var.enable_shared_snapshot && var.enabled ? 1 : 0
  db_cluster_identifier = aws_rds_cluster.this[0].id

  db_cluster_snapshot_identifier = (
    var.db_cluster_snapshot_identifier != null
    ? var.db_cluster_snapshot_identifier
    : substr(
    "sh-${random_string.snapshot[0].result}-${aws_rds_cluster.this[0].id}",
    0,
    63
  )
  )

  shared_accounts = var.shared_accounts_snapshot
  tags            = merge(local.tags, var.tags)
}

resource "random_string" "snapshot" {
  count   = var.enable_shared_snapshot && var.enabled ? 1 : 0
  length  = 5
  special = false
  upper   = false
}
