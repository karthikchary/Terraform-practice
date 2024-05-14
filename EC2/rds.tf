# resource "aws_db_subnet_group" "my_db_subnet_group" {
#   name = "my-db-subnet-group"
#   subnet_ids = [ "us-east-1a", "us-east-1b", "us-east-1c"]
#   tags = {
#     Name = "My DB Subnet Group"
#     Owner = "karthik"
#   }
# }

resource "aws_db_instance" "default" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.medium"
  identifier = "mydb"
  username = "admin"
  password = "dbpassword"
  skip_final_snapshot = true
#   vpc_security_group_ids = [aws_db_subnet_group.my_db_subnet_group.id]
#   db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
}

