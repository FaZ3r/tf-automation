
# ==================ROLES========================
resource "aws_iam_role" "CWAgentTudorRole"{
  name= "CWAgentTudorRole"

  assume_role_policy = file("${path.cwd}/role.json")
}

#===================POLICIES===========================
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
            "Resource": "arn:aws:ssm:${var.current_region}:${data.aws_caller_identity.me.account_id}:parameter/CloudWatchAgentTudor/Config"
        },
        {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
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