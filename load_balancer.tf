resource "aws_lb_target_group" "demo_tg" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demo_vpc.id
}

resource "aws_lb" "demo_alb" {
  name               = "demo-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.MySubnet1.id, aws_subnet.MySubnet2.id]
  security_groups    = [aws_security_group.new_sec_group.id]
}

resource "aws_lb_listener" "demo_listener" {
  load_balancer_arn = aws_lb.demo_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo_tg.arn
  }
}