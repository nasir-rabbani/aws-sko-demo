resource "aws_vpc" "sko-demo-aws-hb" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Owner = "harkirat"
    Name  = "sko-demo-hb"
  }
}

resource "aws_subnet" "sko-demo-aws-hb" {
  vpc_id     = aws_vpc.sko-demo-aws-hb.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Owner = "Harkirat"
  }
}

resource "aws_security_group" "sko-demo-aws-hb" {
  name        = "demo-security-group"
  description = "Used in the terraform"
  vpc_id      = aws_vpc.sko-demo-aws-hb.id

  tags = {
    Owner = "harkirat"
  }

  # SSH access from anywhere
  ingress {
    to_port     = 65535
    from_port   = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0", "192.164.0.0/24"]
  }

  ingress {
    to_port     = 65535
    from_port   = 0
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0", "192.164.0.0/24"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
