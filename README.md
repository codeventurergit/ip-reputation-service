# ip-reputation-service
Serverless, Cloud Native service with a Java API for IP reputation and threat scoring leveraging AWS Lambda, API Gateway, DynamoDB, Terraform, and CI/CD with CodePipeline

🚀 Features
Java AWS Lambda for IP reputation scoring

API key validation

Threat intelligence lookup using DynamoDB

Request logging for audit and analytics

API Gateway HTTP API endpoint

Terraform for full infrastructure provisioning

CodePipeline + CodeBuild for automated CI/CD

Jenkinsfile included as a precursor to future enhancement that adds Jenkins

📡 API Endpoint
Code
POST /ip/reputation
Headers
Code
Content-Type: application/json
X-API-Key: <your-api-key>
Body
json
{
  "ip": "203.0.113.42"
}
Response
json
{
  "ip": "203.0.113.42",
  "risk": "high",
  "reason": "Known malicious IP",
  "timestamp": "2026-04-12T15:08:00Z"
}

🏗️ Architecture
Code
GitHub → CodePipeline → CodeBuild → Terraform → AWS
AWS resources created:

Lambda (Java 21)

API Gateway HTTP API

DynamoDB tables

IAM roles & permissions

🧪 Testing
Insert an API key into DynamoDB

Optionally insert a malicious IP into ip-threat-intel

Call the API using Postman or curl

📄 License
Not licensed at this time 
