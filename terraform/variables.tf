variable "access_key" {}

variable "secret_key" {}

variable "aws_region" {
  type        = string
  description = "AWS Region."
}

variable "db_password" {
  default = ""
}
variable "db_name" {
  default = ""
}
variable "db_subnet_group_name" {
  default = ""
}
variable "vpc_security_group_ids" {
  default = ""
}
variable "username" {
  default = ""
}
variable "identifier" {
  default = ""
}
variable "instance_class" {
  default = ""
}
variable "allocated_storage" {
  default = ""
}