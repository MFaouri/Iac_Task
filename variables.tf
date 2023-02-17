variable "azs" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
#################################
variable "aws_access_key" {
  description = "AWS access key ID."
}
variable "aws_secret_key" {
  description = "AWS secret access key."
}

# variable "project" {}
variable "vpc_name" {
  description = "Name for the VPC"
}

# Launch Template
# variable "image_id" {}
# variable "instance_type" {
#   description = "Instance type for EC2 instances in the ASG"
# }


# Auto Scaling
variable "max_size" {
  description = "The default value is 3"
}

variable "min_size" {

  description = "The default value is 2"
}

variable "desired_capacity" {

  description = "The default value is 3"
}

