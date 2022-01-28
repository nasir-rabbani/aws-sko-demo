
resource "aws_instance" "aws_sko_demo" {
  ami                    = data.aws_ami.sko-demo.id
  instance_type          = "t2.micro"
  hibernation            = false
  vpc_security_group_ids = [aws_security_group.sko-demo-aws-hb.id]
  subnet_id              = aws_subnet.sko-demo-aws-hb.id

  monitoring    = true
  ebs_optimized = true

  associate_public_ip_address = var.data
  tags = {
    Name  = "aws-sko-demo"
    Owner = "harkirat"
  }

  metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }
}
