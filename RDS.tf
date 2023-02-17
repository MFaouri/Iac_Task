resource "aws_db_instance" "example" {
  identifier           = "example"
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t2.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds.id]

  db_subnet_group_name = aws_db_subnet_group.example.name

  tags = {
    Name = "example"
  }
}

resource "aws_db_subnet_group" "example" {
  name        = "example"
  description = "example RDS subnet group"

  subnet_ids = aws_subnet.db.*.id
}

