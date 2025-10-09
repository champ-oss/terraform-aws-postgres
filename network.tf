resource "aws_db_subnet_group" "this" {
  count       = var.enabled ? 1 : 0
  name_prefix = "pg-${var.cluster_identifier_prefix}-"
  subnet_ids  = var.private_subnet_ids
  tags        = merge(local.tags, var.tags)

  lifecycle {
    ignore_changes = [name_prefix]
  }
}