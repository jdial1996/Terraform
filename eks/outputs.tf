output "public_subnet_details" {
  value = {
    for key, value in aws_subnet.public : key => {
      subnet_id = value.id
      cidr      = value.cidr_block

    }
  }
}

output "private_subnet_details" {
  value = {
    for key, value in aws_subnet.private : key => {
      subnet_id = value.id
      cidr      = value.cidr_block
    }
  }
}