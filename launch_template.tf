
resource "aws_iam_role" "CWAgentTudorRole"{
  name= "CWAgentTudorRole"

  assume_role_policy = file("${path.cwd}/role.json")
}
resource "aws_iam_role_policy_attachment" "CWARoleAttachTudor"{
  role= aws_iam_role.CWAgentTudorRole.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
resource "aws_iam_policy" "LogPolicy"{
  name = "LogPolicyTudor"
  description = "Custom policy for creating log streams and logs from ec2"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter",
                "ssm:GetParameters"
            ],
            "Resource": "arn:aws:ssm:${var.current_region}:${me.account_id}:parameter/CloudWatchAgentTudor/Config"
        },
        {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })

}
resource "aws_iam_policy" "S3GetPolicy"{
  name= "S3GetPolicyTudor"
  description = "Custom policy for read only access to my bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Describe*"
            ],
            "Resource": "${aws_s3_bucket.script_bucket.arn}/*"
        }
    ]
})

}
resource "aws_iam_role_policy_attachment" "S3GetAttachTudor"{
  role= aws_iam_role.CWAgentTudorRole.name
  policy_arn = aws_iam_policy.LogPolicy.arn
}

resource "aws_iam_role_policy_attachment" "S3GetAttachTudor"{
  role= aws_iam_role.CWAgentTudorRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
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

  user_data = filebase64("${path.cwd}/instance_prep.sh")

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
