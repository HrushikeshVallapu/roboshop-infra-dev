module "frontend" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  sg_name = var.sg_name
  description = var.description
  vpc_id = local.vpc_id
}