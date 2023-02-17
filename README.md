# Iac_Task
# Creating a Tier 3 Project using Terraform IaC


## Introduction:

This project is an example of how to create a Tier 3 infrastructure using Terraform IaC. The infrastructure includes an Amazon VPC, 3 public and 6 private subnets, an Internet Gateway, NAT Gateway, Elastic Load Balancer, Auto Scaling Group and RDS Database. The project is intended to demonstrate best practices and provide a starting point for building Tier 3 infrastructures in AWS using Terraform.

## Task Structure:

`vpc.tf`  defines the Amazon VPC, including its subnets, Route tables, Internet Gateway, and NAT Gateway.

`security_group.tf` creates security groups for application loadbalancer, launch configuration and RDS database.

`launch_config.tf` creates the launch configuration for the Auto Scaling Group.

`autoscale` creates the Auto Scaling Group and attaches it to the Elastic Load Balancer.

`elb.tf` creates the Application Load Balancer and its listeners and Target group.

`RDS.tf` creates t2.micro instance with mysql engine RDS database

`Provider`The aws provider is configured to allow the Terraform code to interact with AWS.

![Aws architecture diagram ](https://user-images.githubusercontent.com/107811500/219703556-b233ab81-594f-4740-bb20-ab06be7fc2f0.png)

## Conclusion:

By using Terraform to create infrastructure as code, the project has been able to create a high availability environment with three availability zones, 3 public subnets for the Application Load Balancer, 3 private subnets for the Auto Scaling Group, and 3 private subnets for the RDS database. The project also makes use of NAT Gateway in one of the public subnets to provide internet access for the EC2 instances to update packages
