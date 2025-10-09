locals {
  snapshot_timestamp = formatdate("'pg-${var.cluster_identifier_prefix}-'YYYYMMDDHHmmss", timestamp())
  db_snapshot_source = var.db_snapshot_source_arn != null ? data.aws_db_snapshot.this[0].id : null

  # 60 character max length with 27 character random suffix
  cluster_identifier_prefix = trimsuffix("pg-${substr(var.cluster_identifier_prefix, 0, 30)}", "-")


  tags = {
    cost    = "postgres"
    creator = "terraform"
    git     = var.git
  }

  default_kms_policy_actions = [
    "kms:CreateGrant",
    "kms:Decrypt",
    "kms:DescribeKey",
    "kms:Encrypt",
    "kms:GenerateDataKey*",
    "kms:ListGrants",
    "kms:ReEncrypt*",
    "kms:RetireGrant",
    "kms:RevokeGrant",
  ]
}

resource "random_password" "password" {
  count   = var.enabled ? 1 : 0
  length  = 32
  special = false

  lifecycle {
    create_before_destroy = true
  }
}
