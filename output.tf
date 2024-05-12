# output "public_ip" {
#   value = aws_instance.example.public_ip
# }

output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}
output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}
