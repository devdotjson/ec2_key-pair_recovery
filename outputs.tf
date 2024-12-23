output "public_ip" {
  value = aws_instance.test.public_ip
  
}

output "ssh_address" {
  value = "ssh -i '${local_file.working_private_key.filename}' ubuntu@ec2${aws_instance.test.public_ip}.${var.region}.compute.amazonaws.com"
}