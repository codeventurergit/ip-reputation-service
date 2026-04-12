package com.codeventurergit.services;

public class IpReputationResponseService {
    private String ip;
    private String reputation;

    public IpResponse(String ip, String reputation) {
        this.ip = ip;
        this.reputation = reputation;
    }

    public String getIp() { return ip; }
    public String getReputation() { return reputation; }
}
