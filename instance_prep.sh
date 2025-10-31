#!/bin/bash
sudo dnf update -y
sudo dnf install -y amazon-cloudwatch-agent python3

python3 -m ensurepip
pip3 install --upgrade pip
pip3 install randomtimestamp

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/CloudWatchAgentTudor/Config -s