module "kms" {
  count                   = var.enabled && var.create_kms ? 1 : 0
  source                  = "github.com/champ-oss/terraform-aws-kms.git?ref=v1.0.34-a5b529e"
  git                     = "pg-${var.git}"
  name                    = "alias/pg-${var.cluster_identifier_prefix}"
  deletion_window_in_days = var.deletion_window_in_days
  account_actions         = [for account in setunion(var.shared_accounts_snapshot, var.shared_accounts) : { account = account, actions = local.default_kms_policy_actions }]
  tags                    = merge(local.tags, var.tags)
  enabled                 = var.enabled
}
