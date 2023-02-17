resource "aws_security_group" "rds" {
  name_prefix = "rds-"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.example.id


  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.second-tier.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS_SG"
  }

  depends_on = [
    aws_security_group.second-tier
  ]
}

resource "aws_security_group" "second-tier" {
  name_prefix = "app"
  vpc_id      = aws_vpc.example.id

  ingress {
    description     = "Allow traffic from ALB to the ASG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.first-tier.id]
  }

  ingress {
    description     = "Allow traffic from Internet to the ASG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.first-tier.id]
  }

  egress {
    description = "Allow traffic from the ALB to the Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "first-tier" {
  name_prefix = "alb"
  vpc_id      = aws_vpc.example.id

  ingress {
    description = "Allow traffic from Internet to the ALB"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow traffic from the ALB to the Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
