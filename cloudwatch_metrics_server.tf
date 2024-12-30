data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["amd64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "Cloudwatch_metrics_server" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_metrics_server_profile.name
  ebs_optimized = true
  key_name = aws_key_pair.binding.key_name
  #user_data = filebase64("${path.module}/ssm-agent-install.sh")
  subnet_id = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.allow_web.id]
    root_block_device {
        volume_size = 8
        encrypted = true
    }

  tags = {
    Name = var.cloudwatch_metrics_server_name
  }
}

resource "aws_iam_instance_profile" "cloudwatch_metrics_server_profile" {
  name = "cloudwatch_metrics_server_profile"
  role = aws_iam_role.cloudwatch_metrics_agent_role.name
}
resource "aws_iam_role" "cloudwatch_metrics_agent_role" {
  name = "cloudwatch_metrics_agent_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  description = "IAM role for EC2 instances to allow CloudWatch Agent access"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy_attachment" {
  role       = aws_iam_role.cloudwatch_metrics_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

