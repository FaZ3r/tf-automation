
resource "aws_iam_role_policy_attachment" "attach_ssm_policy_tudor" {
    role = aws_iam_role.CWAgentTudorRole.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" 
}          


resource "aws_ssm_parameter" "cloudwatch_config_tudor" { 
    name = "/CloudWatchAgentTudor/Config" 
    type = "String" 
    value = jsonencode({
    logs = {
      logs_collected = {
        files = {
          collect_list = [
            {
              file_path           = "/home/ec2-user/logs.txt"
              log_group_name      = "${aws_cloudwatch_log_group.log_monitor_tudor.name}"
              log_stream_name     = "{instance_id}"
              timestamp_format    = "%Y-%m-%d %H:%M:%S"
            }
          ]
        }
      }
    },
    agent = {
      metrics_collection_interval = 60
      logfile                     = "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
    }
  })
}


data "aws_caller_identity" "me"{}

data "aws_iam_policy_document" "cw_ssm_policy_doc" {
  statement {
    actions   = ["ssm:GetParameter"]
    resources = ["arn:aws:ssm:${var.current_region}:${data.aws_caller_identity.me.account_id}:parameter/CloudWatchAgentTudor/Config"]
  }
}


resource "aws_iam_policy" "cw_ssm_policy" {
  name   = "CloudWatchAgentReadConfigTudor"
  policy = data.aws_iam_policy_document.cw_ssm_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "cw_ssm_attach" {
  role       = aws_iam_role.CWAgentTudorRole.name
  policy_arn = aws_iam_policy.cw_ssm_policy.arn
}

resource "aws_cloudwatch_log_group" "log_monitor_tudor"{
  name = "log-monitor-tudor"
  retention_in_days = 1
}

