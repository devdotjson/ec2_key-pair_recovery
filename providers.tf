terraform {
  ######################################################################
  #If you intend to use a remote backend, uncomment the following block#
  ######################################################################
  # backend "s3" {
  #   bucket = ""
  #   key = ""
  #   region = ""
  #   encrypt = true
  #   dynamodb_table = ""
  # }
  required_version = ">=1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.6"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.2"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
