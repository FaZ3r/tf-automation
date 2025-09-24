resource "aws_launch_template" "demo_lt" {
  name_prefix   = "launch_template"
  instance_type = "t3.micro"
  key_name      = "ec2_key1" 

  network_interfaces {
    security_groups = [var.security_group_id] 
  }
}
