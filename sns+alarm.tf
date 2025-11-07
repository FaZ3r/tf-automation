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
        name = "EventCount"
        namespace= "tudor_namespace"
        value="1"
    }
}

resource "aws_cloudwatch_metric alarm" "ec2-log-alarm"{
    alarm_name = "ec2-log-tudor-alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2

    metric_name= error_filter.name
    alaram_description ="this alarm monitors the occurences of errors in my log stream"
}