terraform {
  backend "s3" {
    bucket = "terraform-state-my-bucket"
    key = "terraform-state/terraform.tfstate"
    region = var.region
  }
}
