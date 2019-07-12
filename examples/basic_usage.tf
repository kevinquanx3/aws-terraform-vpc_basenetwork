provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}

module "vpc" {
  source   = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork//?ref=tf_0.12-upgrade"
  vpc_name = "MyVPC"
}

