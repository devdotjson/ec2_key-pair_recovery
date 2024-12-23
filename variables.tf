variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
  
}

variable "my_ip" {
  description = "My IP address"
  type        = string
  default     = "0.0.0.0" #Change this to your IP address
  
}
variable "working_key_name" {
  description = "Key pair name for the working key"
  type        = string
  default     = "working_key"
  
}

variable "broken_key_name" {
  description = "Key pair name for the broken key"
  type        = string
  default     = "goop"
  
}