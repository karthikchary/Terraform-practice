resource "tls_private_key" "example" {
  algorithm =  "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "${var.key_name}"
  content = tls_private_key.example.private_key_pem
  file_permission = "0400"
}

resource "aws_instance" "example" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = var.instance_type_medium
  vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
  associate_public_ip_address = true
  key_name = aws_key_pair.generated_key.key_name
  user_data = file("install_ansible.sh")
  tags = {
    Name = "webserver",
    owner = "karthik"
  }
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  # provisioner "local-exec" {
  #   command = "touch dynamic_inventory.ini"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo 'EC2 instance is ready.'"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ubuntu"
  #     private_key = tls_private_key.example.private_key_pem
  #   }
  # }
}


resource "aws_instance" "jenkins" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = var.instance_type_medium
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  associate_public_ip_address = true
  key_name = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Jenkins",
    owner = "karthik"
  }
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}