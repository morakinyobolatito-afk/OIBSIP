# Common Network Security Threats

**Author:** Morakinyo
**Track:** OIBSIP — Security Analyst
**Task:** Task 4 — Research Report: Common Network Security Threats

---

## Introduction

Modern organizations depend on interconnected networks to run everyday operations, from email and file sharing to cloud services and customer-facing applications. That same connectivity is what makes networks a constant target. A single successful attack — whether it floods a server with traffic, intercepts a login session, or silently redirects users to a fake website — can cause service outages, financial loss, stolen data, and lasting damage to an organization's reputation. Understanding how the most common network threats work, and how to defend against them, is a foundational skill for any security analyst. This report covers four major threat categories: Denial-of-Service attacks, Man-in-the-Middle attacks, IP Spoofing, and DNS Poisoning/Spoofing.

---

## 1. DoS / DDoS Attacks

**How it works:**
A Denial-of-Service (DoS) attack aims to make a system, service, or network unavailable to its legitimate users by overwhelming it with traffic or resource requests. A Distributed Denial-of-Service (DDoS) attack does the same thing but uses many compromised machines at once — often a botnet — making the flood of traffic larger and harder to block because it originates from thousands of different sources rather than one. Attacks can target different layers of the network stack: volumetric attacks simply try to saturate bandwidth, protocol attacks abuse weaknesses in how connections are established (such as SYN floods), and application-layer (Layer 7) attacks send requests that look legitimate but are deliberately expensive for the server to process, such as repeated HTTP requests to a resource-heavy page.

**Real-world example:**
In February 2018, GitHub was hit by one of the largest DDoS attacks recorded at the time, with incoming traffic peaking at roughly 1.3 terabits per second. The attack exploited misconfigured Memcached servers to amplify traffic volume and briefly knocked the platform offline before GitHub's DDoS mitigation service absorbed the flood. A separate and highly disruptive incident occurred in 2016, when DNS provider Dyn was targeted by a DDoS attack that used the Mirai botnet of compromised IoT devices, causing major outages for sites including Twitter, Netflix, and Reddit.

**Impact:**
Extended downtime, lost revenue, damaged customer trust, and — in some cases — a smokescreen that lets attackers pursue a second, quieter objective like data theft while the security team is distracted by the outage.

**Mitigation strategies:**
1. Deploy a DDoS protection/scrubbing service (e.g., Cloudflare, AWS Shield) that can absorb and filter volumetric traffic before it reaches origin servers.
2. Implement rate limiting and traffic-pattern anomaly detection at the network edge to catch application-layer floods.
3. Maintain redundant infrastructure and a tested incident response plan so services can fail over or scale during an attack rather than going fully offline.

---

## 2. Man-in-the-Middle (MITM) Attacks

**How it works:**
In a MITM attack, an adversary secretly positions themselves between two communicating parties — a user and a website, or two servers — and intercepts, and sometimes alters, the traffic passing between them. Common techniques include setting up a rogue Wi-Fi hotspot, ARP spoofing on a local network, DNS spoofing to redirect a connection, or SSL stripping, where an attacker downgrades an HTTPS connection to plain HTTP so traffic can be read in the clear. Because both parties often believe they are talking directly to each other, MITM attacks can go undetected for long periods.

**Real-world example:**
Between 2024 and 2025, a state-linked threat group known as Salt Typhoon compromised core network infrastructure inside major U.S. telecom providers, including AT&T and Verizon, positioning themselves inside trusted carrier networks to intercept communications traffic and metadata at national scale — a large-scale, infrastructure-level MITM operation rather than a single-victim attack.

**Impact:**
Stolen credentials, session hijacking, exposure of sensitive communications, and follow-on account or system compromise — often without leaving an obvious trace for defenders to catch.

**Mitigation strategies:**
1. Enforce HTTPS everywhere and use HSTS to prevent protocol downgrade/SSL-stripping attacks.
2. Use certificate pinning in mobile and critical applications so forged certificates are rejected automatically.
3. Avoid untrusted public Wi-Fi for sensitive activity, or require a VPN when connecting from untrusted networks.

---

## 3. IP Spoofing

**How it works:**
IP spoofing is the practice of forging the source IP address in a packet header so that traffic appears to originate from a trusted or different host than it actually does. Because many legacy systems and access controls trust traffic based on source IP, spoofing lets an attacker bypass IP-based authentication, hide their true origin, or amplify an attack, as seen in "Smurf" style attacks that reflect traffic off misconfigured networks toward a victim.

**Real-world example:**
IP spoofing was a foundational technique in the 1988 Morris Worm, one of the first major internet security incidents, and it remains a core building block of modern DDoS attacks — including the Mirai-botnet-driven attack on Dyn in 2016, where spoofed and distributed traffic sources made the flood far harder to filter or trace back to its origin.

**Impact:**
Bypassed IP-based access controls, amplified denial-of-service traffic, and difficulty in attributing or blocking the true source of an attack.

**Mitigation strategies:**
1. Implement ingress and egress filtering (e.g., BCP38) at network edges so packets with implausible source addresses are dropped.
2. Avoid relying on IP address alone for authentication; pair it with strong, cryptographic authentication methods.
3. Deploy network monitoring/IDS tools that flag anomalous source-address patterns inconsistent with expected routing.

---

## 4. DNS Poisoning / Spoofing *(bonus threat)*

**How it works:**
DNS poisoning (also called DNS cache poisoning or DNS spoofing) corrupts the records a DNS resolver stores, causing it to return a fraudulent IP address for a legitimate domain name. If an attacker's forged response reaches the resolver before the real one, the false record gets cached and is served to every subsequent user who queries that domain until the cache expires — silently redirecting them to attacker-controlled infrastructure, often to harvest credentials or deliver malware.

**Real-world example:**
The 2008 "Kaminsky attack" exposed a fundamental design flaw in the DNS protocol, showing that cache poisoning could be carried out reliably and at scale, which prompted a coordinated, industry-wide patch effort. In a more targeted 2015 incident, attackers redirected visitors of the Malaysia Airlines website to a page displaying malicious content by tampering with the airline's DNS records.

**Impact:**
Users unknowingly redirected to phishing or malware-hosting sites while believing they are on a legitimate domain, leading to credential theft, malware infections, and reputational damage to the spoofed organization.

**Mitigation strategies:**
1. Deploy DNSSEC to cryptographically sign DNS records so forged responses can be detected and rejected.
2. Use randomized query IDs and source ports for DNS requests to make forged responses harder to guess.
3. Monitor for unexpected DNS record changes and use encrypted DNS resolution (DoH/DoT) with trusted resolvers.

---

## Comparison Table

| Threat | Attack Vector | Who Is at Risk | Difficulty to Execute | Ease of Mitigation |
|---|---|---|---|---|
| DoS/DDoS | Traffic/request flooding, often via botnets | Any internet-facing service | Low–Medium (tools are widely available) | Medium (requires dedicated scrubbing/CDN capacity) |
| MITM | Interception of traffic between two parties | Users on untrusted networks, poorly configured apps | Medium (needs network position or spoofing) | Medium (HTTPS/HSTS/cert pinning are effective but must be enforced everywhere) |
| IP Spoofing | Forged packet source addresses | Networks relying on IP-based trust | Low–Medium | Medium (requires edge filtering adoption industry-wide) |
| DNS Poisoning | Corrupting cached DNS records | Anyone resolving DNS through an affected resolver | Medium–High (modern resolvers are harder to poison) | Medium–High (DNSSEC deployment is still inconsistent) |

---

## Conclusion

Three takeaways stand out for a network administrator:

1. **Availability, confidentiality, and integrity are each targeted differently** — DoS/DDoS attacks availability, MITM attacks confidentiality and integrity of data in transit, and IP spoofing/DNS poisoning attack the trust assumptions networks are built on.
2. **Defense requires layering, not a single control** — no single tool (a firewall, HTTPS, or a scrubbing service alone) stops all four threat types; effective defense combines edge filtering, encryption, monitoring, and redundancy.
3. **Many of today's largest attacks combine multiple techniques** — spoofed IPs amplify DDoS floods, and DNS/MITM techniques are often chained together, so understanding each threat individually is the first step toward recognizing how real attacks combine them.

---

## References

1. National Institute of Standards and Technology (NIST) — https://www.nist.gov
2. Cybersecurity and Infrastructure Security Agency (CISA) — https://www.cisa.gov
3. MITRE ATT&CK Framework — https://attack.mitre.org
4. Radware, "DDoS Examples: 10 DDoS Attacks that Took the World by Storm" — https://www.radware.com/cyberpedia/ddospedia/ddos-examples-10-ddos-attacks-that-took-the-world-by-storm/
5. CyberDefenders, "Man in the Middle (MITM) Attack Glossary" — https://cyberdefenders.org/cybersecurity-glossary/man-in-the-middle-mitm-attack/
6. ManageEngine, "Man-in-the-Middle Attack" — https://www.manageengine.com/uk/products/desktop-central/attack-glossary/man-in-the-middle-attack.md
7. SearchInform, "IP Spoofing Explained: Prevention and Security Measures" — https://searchinform.com/cybersecurity/cyber-threats/type/spoofing/ip-spoofing
8. Portnox, "What is DNS Spoofing?" — https://www.portnox.com/cybersecurity-101/networking/what-is-dns-spoofing/
9. OWASP Ghana, "Anatomy of a DNS Cache Poisoning Attack" — https://wiki.owasp.org/images/b/b4/DNS_Cache_Poisoning%28OWASP_GHANA%29.pdf
