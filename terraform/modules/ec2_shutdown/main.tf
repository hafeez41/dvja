variable "instance_id" {
  description = "EC2 instance ID to stop"
  type        = string
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_ec2_stop_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_ec2_stop_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:StopInstances",
          "ec2:DescribeInstances"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "stop_ec2" {
  function_name = "stop_ec2_after_3hrs"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  filename      = "${path.module}/ec2_stop.zip"
  source_code_hash = filebase64sha256("${path.module}/ec2_stop.zip")

  environment {
    variables = {
      INSTANCE_ID = var.instance_id
    }
  }
}

resource "aws_cloudwatch_event_rule" "ec2_stop_schedule" {
  name                = "ec2_stop_after_3hrs"
  schedule_expression = "rate(3 hours)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.ec2_stop_schedule.name
  target_id = "ec2StopLambda"
  arn       = aws_lambda_function.stop_ec2.arn
}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_stop_schedule.arn
}
