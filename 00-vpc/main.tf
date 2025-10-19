module "vpc" {
  source = "git::https://github.com/HrushikeshVallapu/terraform-aws-vpc.git?ref=main"
  project = "roboshop"
  environment = "dev"
  public_cidrs_block = ["10.0.1.0/24","10.0.2.0/24"]
  private_cidrs_block = ["10.0.11.0/24","10.0.12.0/24"]
  database_cidrs_block = ["10.0.21.0/24","10.0.22.0/24"]
  #is_peering_required = true
}