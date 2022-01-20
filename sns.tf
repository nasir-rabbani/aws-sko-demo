resource "aws_sns_topic" "aws_sko_demo" {
  name   = "aws_sko_demo"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid":"Queue1_AnonymousAccess_AllActions_WhitelistIP",
    "Effect": "Allow",
    "Principal": { "AWS":"*" },
    "Action": [
      "sns:DeleteTopic"
    ],
    "Resource": "*"
  }]
}
EOF
}