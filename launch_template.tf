
resource "aws_iam_role" "CWAgentTudorRole"{
  name= "CWAgentTudorRole"

  assume_role_policy = file("${path.cwd}/role.json")
}
resource "aws_iam_role_policy_attachment" "CWARoleAttachTudor"{
  role= aws_iam_role.CWAgentTudorRole.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_instance_profile" "tf_tudor_profile"{
  name="tf_tudor_profile"
  role= aws_iam_role.CWAgentTudorRole.name
}
resource "aws_launch_template" "demo_lt" {
  name_prefix   = "launch_template"
  image_id = "ami-0971f6afca696ace6"
  instance_type = "t3.micro"
  key_name      = "ec2_key1"
  
  iam_instance_profile{
    name= "tf_tudor_profile"
  }
  network_interfaces {
    security_groups = [aws_security_group.sec_group_tudor.id] 
  }
}