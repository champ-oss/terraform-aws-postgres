resource "aws_rds_cluster_role_association" "s3_export" {
  count                 = var.enabled && var.create_iam_role ? 1 : 0
  db_cluster_identifier = aws_rds_cluster.this[0].id
  feature_name          = "s3Export"
  role_arn              = aws_iam_role.this[0].arn
}

resource "aws_rds_cluster_role_association" "s3_import" {
  count                 = var.enabled && var.create_iam_role ? 1 : 0
  db_cluster_identifier = aws_rds_cluster.this[0].id
  feature_name          = "s3Import"
  role_arn              = aws_iam_role.this[0].arn
}