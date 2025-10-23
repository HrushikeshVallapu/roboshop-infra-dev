resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project}/${var.environment}/sg_id"
  type  = "String"
  value =  module.frontend.sg_id
}

resource "aws_ssm_parameter" "bation_sg_id" {
  name  = "/${var.project}/${var.environment}/bation_sg_id"
  type  = "String"
  value =  module.bation.sg_id
}

resource "aws_ssm_parameter" "backend_alb_sg_id" {
  name  = "/${var.project}/${var.environment}/backend_alb_sg_id"
  type  = "String"
  value =  module.backend_alb.sg_id
}

