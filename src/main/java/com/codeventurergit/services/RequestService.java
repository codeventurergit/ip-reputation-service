package com.codeventurergit.services;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import java.util.Map;

public class RequestService implements RequestHandler<Map<String, Object>, Map<String, Object>> {

    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    public Map<String, Object> handleRequest(Map<String, Object> event, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Received event: " + event);

        try {
            // Extract IP from query string
            Map<String, String> queryParams = (Map<String, String>) event.get("queryStringParameters");
            if (queryParams == null || !queryParams.containsKey("ip")) {
                return response(400, "Missing required query parameter: ip");
            }

            String ip = queryParams.get("ip");
            logger.log("Checking reputation for IP: " + ip);

            // TODO: Replace this placeholder with DynamoDB lookup
            boolean isMalicious = fakeReputationCheck(ip);

            ObjectNode body = mapper.createObjectNode();
            body.put("ip", ip);
            body.put("malicious", isMalicious);
            body.put("score", isMalicious ? 90 : 5);
            body.put("message", isMalicious ? "High-risk IP detected" : "IP appears clean");

            return response(200, body.toString());

        } catch (Exception e) {
            logger.log("Error: " + e.getMessage());
            return response(500, "Internal server error");
        }
    }

    // Temporary placeholder logic — will be replaced with DynamoDB lookup
    private boolean fakeReputationCheck(String ip) {
        return ip.startsWith("192."); // treat private IPs as "malicious" for demo
    }

    private Map<String, Object> response(int statusCode, String body) {
        return Map.of(
                "statusCode", statusCode,
                "headers", Map.of("Content-Type", "application/json"),
                "body", body
        );
    }
}
