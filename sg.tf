resource "aws_security_group" "pg" {
  count       = var.enabled ? 1 : 0
  name_prefix = "${var.cluster_identifier_prefix}-rds-"
  vpc_id      = var.vpc_id
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "from_sg" {
  count                    = var.enabled && var.enable_source_security_group ? 1 : 0
  description              = "ingress from security group"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.pg[0].id
  source_security_group_id = var.source_security_group_id
}

resource "aws_security_group_rule" "from_cidr" {
  count             = var.enabled ? 1 : 0
  description       = "ingress from cidr blocks"
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.pg[0].id
  cidr_blocks       = var.cidr_blocks
}

resource "aws_security_group_rule" "ingress_self" {
  count                    = var.enabled ? 1 : 0
  description              = "ingress self reference"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.pg[0].id
  source_security_group_id = aws_security_group.pg[0].id
}

resource "aws_security_group_rule" "egress" {
  count             = var.enabled ? 1 : 0
  description       = "egress internet"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  security_group_id = aws_security_group.pg[0].id
  cidr_blocks       = ["0.0.0.0/0"]
}
