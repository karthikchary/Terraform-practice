resource "tls_private_key" "example" {
  algorithm =  "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "example" {
  ami = "ami-0ff8a91507f77f867"
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
  associate_public_ip_address = true
  key_name = aws_key_pair.generated_key.key_name
  user_data = <<-EOF
	      #!/bin/bash
	      sudo yum update -y && sudo yum install httpd -y
	      sudo systemctl start httpd && sudo systemctl enable httpd
	      EOF
  tags = {
    Name = "Terraform-example",
    owner = "karthik"
  }
}