variable "region" {
  description = "AWS region"
  type        = string
  default     = "" #The region where the EC2 instance will be created
  
}

variable "my_ip" {
  description = "My IP address"
  type        = string
  default     = "" #Change this to your IP address
  
}
# variable "working_key_name" {
#   description = "Key pair name for the working key"
#   type        = string
#   default     = "working_key"
  
# }

variable "broken_key_name" {
  description = "Key pair name for the broken key"
  type        = string
  default     = "goop"
  
}
variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = ""
  
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  
}

variable "ssm_role_name" {
  description = "Name of the IAM role for SSM"
  type        = string
  default     = "ssm_role_instance"
  
}