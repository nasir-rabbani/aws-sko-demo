provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "sko-demo" {
  most_recent = true
  owners      = ["562105087620"]

  filter {
    name   = "name"
    values = ["accurics-on-prem-code-scanner-2"]
  }
}
