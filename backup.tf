module "backup" {
  source                   = "github.com/champ-oss/terraform-aws-backup.git?ref=v1.0.2-a81b88a"
  enabled                  = var.enabled && var.enable_backup
  git                      = "pg-${var.git}"
  name                     = var.cluster_identifier_prefix
  resource_arn             = try(aws_rds_cluster.this[0].arn, null)
  protect                  = var.protect
  delete_after             = var.backup_delete_after
  enable_continuous_backup = var.enable_continuous_backup
  schedule                 = var.backup_schedule
  tags                     = merge(local.tags, var.tags)
}