resource "aws_launch_template" "demo_lt" {
  name_prefix   = "launch_template"
  image_id = "ami-0971f6afca696ace6"
  instance_type = "t3.micro"
  key_name      = "ec2_key1" 

  network_interfaces {
    security_groups = [aws_security_group.sec_group_tudor.id] 
  }
}
