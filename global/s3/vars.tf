variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  default     = "terraform-state-my-bucket"
}
