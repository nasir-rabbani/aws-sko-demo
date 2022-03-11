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

resource "aws_flow_log" "sko-demo-aws-hb" {
  vpc_id          = "${aws_vpc.sko-demo-aws-hb.id}"
  iam_role_arn    = "<iam_role_arn>"
  log_destination = "${aws_s3_bucket.sko-demo-aws-hb.arn}"
  traffic_type    = "ALL"

  tags = {
    GeneratedBy      = "Accurics"
    ParentResourceId = "aws_vpc.sko-demo-aws-hb"
  }
}
resource "aws_s3_bucket" "sko-demo-aws-hb" {
  bucket        = "sko-demo-aws-hb_flow_log_s3_bucket"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled    = true
    mfa_delete = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
resource "aws_s3_bucket_policy" "sko-demo-aws-hb" {
  bucket = "${aws_s3_bucket.sko-demo-aws-hb.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "sko-demo-aws-hb-restrict-access-to-users-or-roles",
      "Effect": "Allow",
      "Principal": [
        {
          "AWS": [
            <principal_arn>
          ]
        }
      ],
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.sko-demo-aws-hb.id}/*"
    }
  ]
}
POLICY
}