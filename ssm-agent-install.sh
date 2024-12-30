#!/bin/bash
sudo apt-get update -y
sudo mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo snap start amazon-ssm-agent
rm amazon-ssm-agent.deb