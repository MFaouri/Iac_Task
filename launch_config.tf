resource "aws_launch_configuration" "web" {
  name_prefix                 = "web-"
  image_id                    = "ami-0c0d3776ef525d5dd"
  instance_type               = "t2.micro"
  key_name                    = null
  security_groups             = [aws_security_group.second-tier.id]
  associate_public_ip_address = true
  user_data                   = file("ec2-init.sh")
  lifecycle {
    create_before_destroy = true
  }
}
