data "aws_availability_zones" "available" {}

locals {
  name   = "lost-keypair"
  region = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Environment = "StudyWithMe"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name            = local.name
  cidr            = local.vpc_cidr
  azs             = local.azs
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]  
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  enable_dns_hostnames = true
  enable_dns_support   = true
  single_nat_gateway = true
  enable_nat_gateway = true
  vpc_flow_log_iam_role_name            = "lost-keypair-vpc"
  vpc_flow_log_iam_role_use_name_prefix = false
  enable_flow_log                       = true
  create_flow_log_cloudwatch_log_group  = true
  create_flow_log_cloudwatch_iam_role   = true
  flow_log_max_aggregation_interval     = 60

  tags = local.tags
}