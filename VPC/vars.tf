variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "environment" {
  default = "test"
}

variable "public_subnets_cidr" {
  type    = number
  default = "10.0.0.0/24"
}

variable "private_subnets_cidr" {
  type    = number
  default = "10.0.0.1/24"
}

variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

