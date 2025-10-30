
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

 provisioner "file"{
    source="${path.cwd}/log_generator2.py"
    destination = "/home/ec2-user/log_generator2.py"

    connection {
      type="SSH"
      user="ec2-user"
      private_key="~/my_key.pem"
      host="${self.public_ip}"
    }
  }
  
  iam_instance_profile{
    name= "tf_tudor_profile"
  }
  network_interfaces {
    security_groups = [aws_security_group.sec_group_tudor.id] 
  }
}


resource "aws_cloudwatch_log_group" "log_monitor_tudor"{
  name = "log-monitor-tudor"
  retention_in_days = 14
}
