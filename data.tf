data "aws_db_snapshot" "this" {
  count                  = var.enabled && var.db_snapshot_source_arn != null ? 1 : 0
  db_snapshot_identifier = var.db_snapshot_source_arn
  snapshot_type          = "manual"
}
