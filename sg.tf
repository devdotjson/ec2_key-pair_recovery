resource "aws_security_group" "allow_web" {
  name        = "lost-keypair-allow-webandssh"
  vpc_id      = module.vpc.vpc_id
  description = "Allows access to Web Port"
  #allow http 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow https
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}"]
  }
  #all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    stack = "test"
    Environment = "StudyWithMe"
  }
  lifecycle {
    create_before_destroy = true
  }
}