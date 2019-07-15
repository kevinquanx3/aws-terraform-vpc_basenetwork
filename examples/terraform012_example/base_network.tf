###############################################################################
# Base Network
# https://github.com/rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork
###############################################################################

module "base_network" {
  source              = "github.com/rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork//?ref=tf_0.12-upgrade"
  vpc_name            = var.vpc_name
  cidr_range          = var.cidr_range
  custom_azs          = var.custom_azs
  public_cidr_ranges  = var.public_cidr_ranges
  private_cidr_ranges = var.private_cidr_ranges
  build_nat_gateways  = var.build_nat_gateways
  environment         = var.environment
  az_count            = var.az_count
  custom_tags = {
    CustomTag1 = "CustomTagValue1"
    CustomTag2 = "CustomTagValue3"
  }
  private_subnet_tags = {
    PrivateSubnetTag1 = "PrivateSubnetTagValue1"
    PrivateSubnetTag2 = "PrivateSubnetTagValue2"
  }
  public_subnet_tags = {
    PublicSubnetTag1 = "PublicSubnetTagValue1"
    PublicSubnetTag1 = "PublicSubnetTagValue1"
  }
}


# VPC ID
output "base_network_vpc_id" {
  description = "The ID of the VPC"
  value       = module.base_network.vpc_id
}


# Private Subnets
output "base_network_private_subnets" {
  description = "The IDs for the private subnets"
  value       = module.base_network.private_subnets
}

# Private Subnet - AZ1
data "aws_subnet_ids" "PrivateAZ1" {
  vpc_id = module.base_network.vpc_id

  tags = {
    Name = "${var.vpc_name}-Private1"
  }
}

output "PrivateAZ1" {
  description = "The ID for the private subnet in AZ1"
  value       = element(tolist(data.aws_subnet_ids.PrivateAZ1.ids), 0)
}

# Private Subnet - AZ2
data "aws_subnet_ids" "PrivateAZ2" {
  vpc_id = module.base_network.vpc_id

  tags = {
    Name = "${var.vpc_name}-Private2"
  }
}

output "PrivateAZ2" {
  description = "The ID for the private subnet in AZ2"
  value       = element(tolist(data.aws_subnet_ids.PrivateAZ2.ids), 0)
}

# Public Subnets
output "base_network_public_subnets" {
  description = "The IDs of the public subnets"
  value       = module.base_network.public_subnets
}

# Public Subnet - AZ1
data "aws_subnet_ids" "PublicAZ1" {
  vpc_id = module.base_network.vpc_id

  tags = {
    Name = "${var.vpc_name}-Public1"
  }
}

output "PublicAZ1" {
  description = "The ID for the public subnet in AZ1"
  value       = element(tolist(data.aws_subnet_ids.PublicAZ1.ids), 0)
}

# Public Subnet - AZ2
data "aws_subnet_ids" "PublicAZ2" {
  vpc_id = module.base_network.vpc_id

  tags = {
    Name = "${var.vpc_name}-Public2"
  }
}

output "PublicAZ2" {
  description = "The ID for the public subnet in AZ2"
  value       = element(tolist(data.aws_subnet_ids.PublicAZ2.ids), 0)
}

# Nat Gateway - AZ1

data "aws_nat_gateway" "NatAZ1" {
  subnet_id = element(tolist(data.aws_subnet_ids.PublicAZ1.ids), 0)
}

output "NatPublicIPAZ1" {
  description = "The NAT gateway Public IP in Public AZ1"
  value       = data.aws_nat_gateway.NatAZ1.public_ip
}

output "NatPrivateIPAZ1" {
  description = "The NAT gateway private IP in Public AZ1"
  value       = data.aws_nat_gateway.NatAZ1.private_ip
}

# Nat Gateway AZ2
data "aws_nat_gateway" "NatAZ2" {
  subnet_id = element(tolist(data.aws_subnet_ids.PublicAZ2.ids), 0)
}

output "NatPublicIPAZ2" {
  description = "The NAT gateway Public IP in Public AZ2"
  value       = data.aws_nat_gateway.NatAZ2.public_ip
}

output "NatPrivateIPAZ2" {
  description = "The NAT gateway private IP in Public AZ2"
  value       = data.aws_nat_gateway.NatAZ2.private_ip
}
