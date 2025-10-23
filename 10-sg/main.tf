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

resource "aws_security_group_rule" "bation_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bation.sg_id
}

#connection from bation to backend_alb
resource "aws_security_group_rule" "bation_alb_backend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bation.sg_id
  security_group_id = module.backend_alb.sg_id
}
