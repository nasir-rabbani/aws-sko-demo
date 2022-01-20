resource "aws_lambda_function" "lambdaWithSecrets" {
  handler     = "index.handler"
  timeout     = "3"
  filename    = "lambda_function.zip"
  description = "Akamai Uncache resources from S3 events"
  environment {
    variables = {
      HOST                 = "akab-3qb6t4ss3ecfpz4x-yuk5e6i4s273r5f3.purge.akamaiapis.net"
      S3_REGION            = "us-east-1"
      LOGGLY_TAG           = "S3_AKAMAI_UNCACHE"
      ACCESS_TOKEN         = "akab-igahwuvebpoupigt-mzkf4mcpr6oufey3"
      CLIENT_TOKEN         = "akab-z3xuz44b5t6nm5jg-ohq3ngbuh2rmbwog"
      LOGGLY_TOKEN         = "5c0c26f6-5514-4473-a972-be037afa98b6"
      CLIENT_SECRET        = "LMBphP70Y+sJAEUzFkEKBCA74cipj/qVPs8VspoHLAU="
      S3_ACCESS_KEY        = "AKIAILUU2NFCPWYRN3LA"
      S3_SECRET_ACCESS_KEY = "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"

    }
  }
  function_name                  = "NBA-S3-Upload-Uncache-East1"
  role                           = aws_iam_role.sko-aws-demo.arn
  memory_size                    = "128"
  reserved_concurrent_executions = "-1"
  runtime                        = "nodejs12.x"

  package_type = "Zip"

  tracing_config {
    mode = "Active"
  }

  vpc_config {
    subnet_ids         = [aws_subnet.sko-demo-aws-hb.id]
    security_group_ids = [aws_security_group.sko-demo-aws-hb.id]
  }

  tags = {
    Owner       = "Jesse Graupmann"
    Product     = "Uncache"
    Project     = "Uncache"
    Department  = 55201
    Environment = "PROD"
  }
}
