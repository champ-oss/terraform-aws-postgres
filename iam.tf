resource "aws_iam_role" "pg_enhanced_monitoring" {
  count  = var.enabled ? 1 : 0
  name_prefix        = "pg-rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.pg_rds_enhanced_monitoring.json
  tags               = merge(local.tags, var.tags)
}

resource "aws_iam_role_policy_attachment" "pg_rds_enhanced_monitoring" {
  count  = var.enabled ? 1 : 0
  role       = aws_iam_role.pg_enhanced_monitoring[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "pg_rds_enhanced_monitoring" {
  count  = var.enabled ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count              = var.enabled && var.create_iam_role ? 1 : 0
  name_prefix        = substr("${local.cluster_identifier_prefix}-", 0, 38)
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  tags               = merge(local.tags, var.tags)
}

data "aws_iam_policy_document" "assume_role" {
  count = var.enabled && var.create_iam_role ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [
        "scheduler.amazonaws.com",
        "rds.amazonaws.com"
      ]
    }
  }
}

