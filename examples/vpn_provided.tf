module "vpn_vpc" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork//?ref=tf_0.12-upgrade"

  vpc_name  = "MyVPC"
  build_vpn = true
  spoke_vpc = true
}

