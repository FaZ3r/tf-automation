resource "aws_instance" "my_ec2" {
  instance_type = "t3.micro"
  key_name      = var.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = "WorkflowPipe"
  }
}
