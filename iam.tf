resource "aws_iam_role" "sko-aws-demo" {
  name = "aws-sko-demo"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    owner = "harkirat"
  }
}


resource "aws_iam_role_policy" "aws-sko-demo" {
  name = "aws-sko-demo"
  role = aws_iam_role.sko-aws-demo.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:passrole",
        "s3:GetObject",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
