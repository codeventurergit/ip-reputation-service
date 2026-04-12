###############################################
# DynamoDB Table for IP Reputation
###############################################

resource "aws_dynamodb_table" "ip_reputation" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ip"

  attribute {
    name = "ip"
    type = "S"
  }
}
