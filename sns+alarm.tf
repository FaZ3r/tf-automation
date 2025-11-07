resource "aws_sns_topic" "tudor_alarm"{
    name ="tudor-alarm-topic"
}

resource "aws_sns_topic_subscription" "tudor_mail_sub"{
    topic_arn = aws_sns_topic.tudor_alarm.arn
    protocol = "email"
    endpoint = "burner.tudor@proton.me"
}

resource "aws_cloudwatch_log_metric_filter" "error_filter"{
    name = "error-filter-tudor"
    pattern = "ERROR"
    log_group_name= aws_cloudwatch_log_group.log_monitor_tudor.name

    metric_transformation {
        name = "EventCountTudor"
        namespace= "tudor_namespace"
        value="1"
    }
}

resource "aws_cloudwatch_metric_alarm" "ec2-log-alarm"{
    alarm_name = "ec2-log-tudor-alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 1
    
    statistic = "Sum"
    period = 60
    threshold = 0

    metric_name= "EventCountTudor"
    namespace = "tudor_namespace"

    alarm_description ="Alarm when 'ERROR' occurs in logs"
    alarm_actions = aws_sns_topic.tudor_alarm.arn
}