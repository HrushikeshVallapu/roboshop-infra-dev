resource "aws_instance" "bation" {
  ami           = data.aws_ami.example
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.bation_sg_id.value]
  subnet_id = local.public_subnet_ids[0]

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bation"
    }
  )
}