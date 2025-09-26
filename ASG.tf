resource "aws_autoscaling_group" "demo_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.MySubnet1.id, aws_subnet.MySubnet2.id]

  launch_template {
    id     = aws_launch_template.demo_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.demo_tg.arn]
}