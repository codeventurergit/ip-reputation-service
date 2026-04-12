###############################################
# API Gateway REST API
###############################################

resource "aws_api_gateway_rest_api" "ip_api" {
  name        = "ip-reputation-api"
  description = "API Gateway for IP reputation lookup"
}

###############################################
# /lookup resource
###############################################

resource "aws_api_gateway_resource" "ip_lookup" {
  rest_api_id = aws_api_gateway_rest_api.ip_api.id
  parent_id   = aws_api_gateway_rest_api.ip_api.root_resource_id
  path_part   = "lookup"
}

###############################################
# GET /lookup
###############################################

resource "aws_api_gateway_method" "get_ip" {
  rest_api_id   = aws_api_gateway_rest_api.ip_api.id
  resource_id   = aws_api_gateway_resource.ip_lookup.id
  http_method   = "GET"
  authorization = "NONE"
}

###############################################
# Lambda Integration
###############################################

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ip_api.id
  resource_id             = aws_api_gateway_resource.ip_lookup.id
  http_method             = aws_api_gateway_method.get_ip.http_method
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ip_reputation.invoke_arn
  integration_http_method = "POST"
}

###############################################
# Allow API Gateway to invoke Lambda
###############################################

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ip_reputation.function_name
  principal     = "apigateway.amazonaws.com"
}

###############################################
# Deployment + Stage
###############################################

resource "aws_api_gateway_deployment" "deploy" {
  depends_on = [aws_api_gateway_integration.lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.ip_api.id
  stage_name  = "prod"
}
