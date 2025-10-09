resource "aws_dms_endpoint" "this" {
  depends_on    = [aws_rds_cluster_instance.this]
  count         = var.enabled && var.create_dms_endpoint ? 1 : 0
  endpoint_id   = aws_rds_cluster.this[0].cluster_identifier
  endpoint_type = var.dms_endpoint_type
  engine_name   = "aurora-postgresql"
  database_name = var.database_name
  password      = random_password.password[0].result
  port          = 5532
  server_name   = var.dms_endpoint_read_only ? aws_rds_cluster.this[0].reader_endpoint : aws_rds_cluster.this[0].endpoint
  tags          = merge(local.tags, var.tags)
  username      = aws_rds_cluster.this[0].master_username

  timeouts {
    create = "60m"
    delete = "60m"
  }
}