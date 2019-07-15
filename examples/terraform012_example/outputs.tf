###############################################################################
# Outputs
# terraform output terraform_remote_state_configuration_example
# terraform output terraform_remote_state_import_example
###############################################################################

output "terraform_remote_state_configuration_example" {
  value = <<EOF
  terraform {
    backend "s3" {
      # this key must be unique for each layer!
      key    = "000base/terraform.tfstate"
      bucket = "rs-tfstate-${var.aws_account_id}-${var.region}"
      region = "${var.region}"
      dynamodb_table = "terraform-state"
      encrypt        = "true"
    }
  }
EOF

  description = "Terraform block to put into the build layers"
}

output "terraform_remote_state_import_example" {
  value = <<EOF
  data "terraform_remote_state" "base_network" {
    backend = "s3"
    config = {
      bucket = "rs-tfstate-${var.aws_account_id}-${var.region}"
      region = "${var.region}"
    }
  }
EOF

  description = "Example how to use remote state from other layers"
}

###############################################################################
# Outputs
# terraform output summary
###############################################################################

output "summary" {
  value = <<EOF

## Outputs - 000base layer
| Resource | Value |
|---|---|
| vpc_id | ${module.base_network.vpc_id} |
| PrivateAZ1 | ${element(tolist(data.aws_subnet_ids.PublicAZ1.ids), 0)} |
| PrivateAZ2 | ${element(tolist(data.aws_subnet_ids.PrivateAZ2.ids), 0)} |
| PublicAZ1 | ${element(tolist(data.aws_subnet_ids.PublicAZ1.ids), 0)} |
| PublicAZ2 | ${element(tolist(data.aws_subnet_ids.PublicAZ2.ids), 0)} |
| NatPublicIPAZ1 | ${data.aws_nat_gateway.NatAZ1.public_ip} |
| NatPrivateIPAZ1 | ${data.aws_nat_gateway.NatAZ1.private_ip} |
| NatPublicIPAZ2 | ${data.aws_nat_gateway.NatAZ2.public_ip} |
| NatPrivateIPAZ2 | ${data.aws_nat_gateway.NatAZ2.private_ip} |

EOF

  description = "Base Network Layer Outputs Summary `terraform output summary` "
}

