variable "environment" {
  default = "dev"
}

variable "project" {
  default = "roboshop"
}

variable "frontend_sg_name"{
    default = "frontend"
}

variable "frontend_description" {
  default = "created sg for frontend instance"
}

variable "bation_sg_name"{
    default = "bation"
}

variable "bation_description" {
  default = "created sg for bation instance"
}

