# Task 2 — Basic Firewall Configuration with UFW

**Track:** OIBSIP Security Analyst Internship
**Author:** Morakinyo

## Objective

Set up and configure a basic firewall on a Linux system using UFW (Uncomplicated Firewall), applying rules to allow and deny specific types of traffic.

## Lab Setup

- **Machine:** Kali Linux (VirtualBox)
- UFW was already present on Kali; verified and configured directly

## What is a Firewall?

A firewall is a network security system that monitors and controls incoming and outgoing network traffic based on a defined set of rules. It acts as a barrier between a trusted internal system and untrusted external networks, allowing legitimate traffic through while blocking traffic that doesn't meet the configured rules.

## Rules Applied

| Port/Service | Action | Reason |
|---|---|---|
| 22 (SSH) | ALLOW | SSH is needed for secure remote administration of the machine |
| 80 (HTTP) | DENY | Required by the task; also demonstrates blocking unencrypted web traffic |
| 443 (HTTPS) | ALLOW | Added as the secure counterpart to HTTP — encrypted web traffic is permitted while plaintext HTTP is not |
| 23 (Telnet) | DENY | Telnet transmits credentials and data in plaintext with no encryption, making it a significant security risk if left open |

## Commands Used

```bash
sudo ufw enable
sudo ufw allow ssh
sudo ufw deny http
sudo ufw allow https
sudo ufw deny 23
sudo ufw status verbose
```

## Verification

Ran `sudo ufw status verbose` and `sudo ufw status numbered` to confirm all rules were active for both IPv4 and IPv6. Output confirmed:
- Default policy: deny incoming, deny outgoing, deny routed
- All 4 custom rules applied correctly, each with an IPv6 equivalent

## Testing That Denied Traffic Is Blocked

Tested the HTTP deny rule by running:
```bash
curl http://localhost
```
The command produced no response and hung indefinitely (confirmed via Ctrl+C to interrupt it), rather than returning a webpage or an immediate error. This confirms the DENY rule on port 80 is actively blocking the connection attempt at the firewall level, since nothing was returned for the request.

## Files

- `ufw_configuration.sh` — runnable script that applies all five rules in sequence
- Screenshots of terminal output showing rule creation, verification, and the blocked-traffic test

## What Each Rule Achieves

- **Allowing SSH** ensures the machine remains remotely manageable over an encrypted channel.
- **Denying HTTP** closes off an unencrypted web service port that could expose data in transit.
- **Allowing HTTPS** keeps secure, encrypted web traffic available while still blocking its insecure counterpart.
- **Denying Telnet (23)** removes a legacy, plaintext remote-login protocol that has no place in a hardened system — SSH already covers that need securely.
