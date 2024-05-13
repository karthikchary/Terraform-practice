variable "region" {
  default = "us-east-1"
}

variable "httpd_port" {
  default = "80"
}

variable "ssh_port" {
  default = "22"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {}