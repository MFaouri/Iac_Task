resource "aws_autoscaling_group" "web" {
  name             = "web1-asg"
  min_size         = var.min_size != null && var.min_size != "" ? var.min_size : 2
  desired_capacity = var.desired_capacity != null && var.desired_capacity != "" ? var.desired_capacity : 3
  max_size         = var.max_size != null && var.max_size != "" ? var.max_size : 3

  health_check_type    = "ELB"
  target_group_arns    = [aws_alb_target_group.this.arn]
  launch_configuration = aws_launch_configuration.web.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = aws_subnet.app.*.id
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
