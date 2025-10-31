#!/bin/bash
sudo dnf update
sudo dnf install -y amazon-cloudwatch-agent python3

python3 -m ensurepip
pip3 install --upgrade pip
pip3 install randomtimestamp

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c ssm:/CloudWatchAgentTudor/Config \
  -s

  aws s3 cp s3://tudor-script-bucket1/log_generator2.py .
