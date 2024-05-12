# resource "aws_instance" "example" {
#   ami = "ami-0ff8a91507f77f867"
#   instance_type = var.instance_type
#   vpc_security_group_ids = ["${aws_security_group.web-sg.id}"]
#   user_data = <<-EOF
# 	      #!/bin/bash
# 	      sudo yum update -y && sudo yum install httpd -y
# 	      sudo systemctl start httpd && sudo systemctl enable httpd
# 	      EOF
#   tags = {
#     Name = "Terraform-example",
#     owner = "karthik"
#   }
# }



resource "aws_launch_configuration" "example" {
  image_id        = "ami-0ff8a91507f77f867"
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.web-sg.id}"]
  user_data       = <<-EOF
    #!/bin/bash
    sudo yum update -y && sudo yum install httpd -y
    sudo systemctl start httpd && sudo systemctl enable httpd
    EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  load_balancers       = ["${aws_elb.example.name}"]
  health_check_type    = "ELB"
  min_size             = 2
  max_size             = 5
  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_elb" "example" {
  name               = "terraform-asg-example"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  security_groups    = ["${aws_security_group.elb.id}"]
  
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.httpd_port}"
    instance_protocol = "http"
  }
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.httpd_port}/"
  }
}
