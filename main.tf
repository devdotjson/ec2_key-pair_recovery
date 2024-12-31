data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "lost_key_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.lost_keypair_profile.name
  ebs_optimized = true
  key_name = aws_key_pair.binding.key_name
  user_data = filebase64("${path.module}/ssm-agent-install.sh")
  subnet_id = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.allow_web.id]
    root_block_device {
        volume_size = 8
        encrypted = true
    }

  tags = {
    Name = var.ec2_name
  }
}


resource "aws_key_pair" "binding" {
  key_name   = var.broken_key_name
  public_key = tls_private_key.ED25519.public_key_openssh
  #public_key = tls_private_key.working_key.public_key_openssh
  
}

#################
#Broken Key_Pair#
#################
resource "tls_private_key" "broken" {
  algorithm = "ED25519"
  
}

resource "local_file" "broken_private_key" {
  content  = tls_private_key.broken.private_key_pem
  filename = "${aws_key_pair.binding.key_name}.pem"

}

# Ensure the file permissions are secure
resource "null_resource" "broken_secure_key_permissions" {
  provisioner "local-exec" {
    command = "chmod 400 ${local_file.broken_private_key.filename}"
  }
  depends_on = [local_file.working_private_key]
}

##################
#Working Key_Pair#
##################
resource "tls_private_key" "working_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
  
}

resource "tls_private_key" "ED25519" {
  algorithm = "ED25519"
  
}

resource "local_file" "working_private_key" {
  content  = tls_private_key.ED25519.private_key_openssh
  filename = "${aws_key_pair.binding.key_name}.pem"

}

# Ensure the file permissions are secure
resource "null_resource" "secure_key_permissions" {
  provisioner "local-exec" {
    command = "chmod 400 ${local_file.working_private_key.filename}"
  }
  depends_on = [local_file.working_private_key]
}