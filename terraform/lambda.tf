###############################################
# IAM Role for Lambda
###############################################

resource "aws_iam_role" "lambda_role" {
  name = "ip_reputation_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

###############################################
# IAM Policy for Lambda (CloudWatch + DynamoDB)
###############################################

resource "aws_iam_role_policy" "lambda_policy" {
  name = "ip_reputation_lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # CloudWatch Logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      # DynamoDB read access
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query"
        ]
        Resource = "*"
      }
    ]
  })
}

###############################################
# Lambda Function
###############################################

resource "aws_lambda_function" "ip_reputation-service" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn

  # Lambda service handler that receives requests
  handler = "com.codeventurergit.services.RequestService::handleRequest"

  runtime = "java21"

  # Path to the JAR built by Maven
  filename         = "../target/ip-reputation-cloud-native-service-1.0.0-shaded.jar"
  source_code_hash = filebase64sha256("../target/ip-reputation-cloud-native-service-1.0.0-shaded.jar")

  memory_size = 512
  timeout     = 10
}
