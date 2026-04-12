variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for IP reputation data"
  type        = string
  default     = "ip_reputation"
}
