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

variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  default     = "terraform-state-my-bucket"
}
