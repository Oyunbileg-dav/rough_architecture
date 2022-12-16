variable "region" {
    type = string
    default = "sa-east-1"
}

variable "main_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "private_cidr_blocks" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ecr_application_tier" {
  type    = string
  default = "app-application-tier"
}

variable "ecr_presentation_tier" {
  type    = string
  default = "app-presentation-tier"
}

# rds variables
variable "rds_db_admin" {
  type = string
  default = "admin"
}

variable "rds_db_password" {
  type = string
  default = "password"
}

variable "multi_az" {
  type = bool
  default = false
}

variable "db_name" {
  type = string
  default = "my_db"
}

variable "engine_version" {
  type = string
  default = "5.7.31"
}

variable "allocated_storage" {
  type = number
  default = 10
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "db_engine" {
  default = "mysql"
}

