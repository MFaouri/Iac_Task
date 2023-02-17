resource "aws_lb" "web_lb" {
  name               = "Task"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.first-tier.id]
  subnets            = aws_subnet.public.*.id
  idle_timeout       = 90
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn

  }
}

resource "aws_alb_target_group" "this" {
  name        = "target"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.example.id

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}



