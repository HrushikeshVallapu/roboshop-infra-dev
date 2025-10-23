module "backend_alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "9.16.0"
  name    = "${var.project}-${var.environment}-backend-alb"
  vpc_id  = local.vpc_id
  subnets = [local.private_subnet_ids]
  create_security_group = false
  internal = true
  
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}