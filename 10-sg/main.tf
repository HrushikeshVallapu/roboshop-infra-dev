module "frontend" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-securitygroup.git?ref=main"
  environment = var.environment
  project = var.project
  
}