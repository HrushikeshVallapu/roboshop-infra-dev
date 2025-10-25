module "frontend" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  sg_name = var.frontend_sg_name
  description = var.frontend_description
  vpc_id = local.vpc_id
}

module "bation" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  sg_name = var.bation_sg_name
  description = var.bation_description
  vpc_id = local.vpc_id
}

#this is sg of alb (private lb) 
module "backend_alb" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  sg_name = "backend_alb"
  description = "security of backend alb"
  vpc_id = local.vpc_id
}

module "vpn" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  sg_name = "vpn"
  description = "for vpn"
  vpc_id = local.vpc_id
}

resource "aws_security_group_rule" "bation_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bation.sg_id
}

#connection/route for bation to backend_alb
resource "aws_security_group_rule" "bation_alb_backend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bation.sg_id
  security_group_id = module.backend_alb.sg_id
}

#VPN ports 22, 443, 1194, 943
resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "backend_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.backend_alb.sg_id
}