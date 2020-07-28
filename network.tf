resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


resource "aws_eip" "dockerhost"{
    instance = aws_instance.dockerhost.id
}

data "aws_subnet_ids" "default" {
  vpc_id = aws_default_vpc.default.id
}


output "public_ip" {
    value = aws_eip.dockerhost.public_ip
}
