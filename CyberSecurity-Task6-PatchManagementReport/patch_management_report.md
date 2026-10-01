# The Importance of Patch Management

**Author:** Morakinyo
**Track:** OIBSIP — Security Analyst
**Task:** Task 6 — Research Report: The Importance of Patch Management

---

## Introduction

Patch management is the process of identifying, acquiring, testing, and deploying updates (patches) to software, operating systems, and firmware in order to fix known security vulnerabilities, bugs, and performance issues. Every piece of software a vendor ships eventually has vulnerabilities discovered in it — the vulnerability lifecycle runs from discovery, to public disclosure and cataloguing (as a CVE), to a vendor releasing a fix, to organizations deploying that fix. The gap between a patch becoming available and an organization actually applying it is one of the largest, most preventable attack surfaces in cybersecurity — attackers routinely weaponize known, already-patched vulnerabilities simply because so many systems remain unpatched for weeks, months, or years.

---

## Why Patches Matter

Vulnerabilities are typically discovered by security researchers, vendors' internal teams, or sometimes by attackers themselves. Once discovered, they're catalogued publicly as CVEs (Common Vulnerabilities and Exposures) with a unique identifier and scored for severity using the CVSS (Common Vulnerability Scoring System). Vendors then race to release a patch, but the vulnerability's existence — and often technical details about how to exploit it — becomes public knowledge the moment it's disclosed. From that point forward, every unpatched system running the affected software is a known, documented target.

**Real-world breach 1 — WannaCry / EternalBlue (2017):**
Microsoft released a patch (MS17-010) for the EternalBlue vulnerability in Windows SMBv1 in March 2017. Two months later, in May 2017, the WannaCry ransomware worm used that exact unpatched vulnerability to spread automatically across networks, infecting roughly 200,000 systems in over 150 countries, including large parts of the UK's National Health Service — forcing cancelled appointments and causing tens of millions of pounds in recovery costs. Systems that had applied the two-month-old patch were unaffected.

**Real-world breach 2 — Equifax (2017):**
A critical vulnerability in Apache Struts (CVE-2017-5638) was publicly disclosed and patched on March 7, 2017. Equifax's security team was aware of the vulnerability and attempted to scan for it, but a flawed internal patching process failed to identify or update the affected system. Attackers exploited that same unpatched vulnerability starting in mid-May 2017, ultimately exposing the sensitive personal and financial data of roughly 147 million people — one of the largest breaches in U.S. history, caused entirely by a patch that had been available for over two months before the breach began.

---

## Consequences of Not Patching

- **Data breaches** — as seen with Equifax, unpatched vulnerabilities are a direct entry point for attackers to access sensitive data at massive scale.
- **Ransomware attacks** — WannaCry and its successor NotPetya both spread specifically through unpatched systems, encrypting data and demanding payment.
- **Compliance violations** — regulatory frameworks (PCI-DSS, HIPAA, GDPR, ISO 27001) generally require timely patching; failure to patch can itself constitute a compliance violation independent of whether a breach occurs.
- **Financial penalties** — Equifax ultimately paid over $700 million in settlements and fines following its breach; the UK's NHS estimated WannaCry cost it roughly £92 million in direct recovery and disruption costs.

---

## Patch Management Lifecycle

1. **Discovery** — identifying that a vulnerability exists, either through vendor disclosure, a CVE announcement, internal vulnerability scanning, or threat intelligence feeds.
2. **Assessment** — evaluating the vulnerability's severity (commonly via its CVSS score) and relevance to the organization's specific systems, to prioritize which patches need urgent attention.
3. **Testing** — applying the patch in a non-production/staging environment first, to confirm it doesn't break existing functionality or introduce instability.
4. **Deployment** — rolling the tested patch out to production systems, ideally through an automated patch management system that can track which assets have and haven't received it.
5. **Verification** — confirming the patch was successfully applied across all affected systems and that the vulnerability is actually closed, often via a follow-up vulnerability scan.

---

## Best Practices: A 7-Step Patch Management Checklist

1. Maintain a complete, continuously updated asset inventory — you cannot patch what you don't know you have.
2. Subscribe to vendor and CVE/NVD notifications so new vulnerabilities affecting your stack are flagged immediately.
3. Triage and prioritize patches by CVSS severity and actual exposure (internet-facing systems first).
4. Test patches in a staging environment before production deployment, with a defined rollback plan.
5. Use automated patch management tooling to deploy at scale and track patch status across all assets.
6. Set and enforce maximum patch windows (e.g., critical patches applied within 72 hours, high within 2 weeks).
7. Regularly audit and verify patch compliance with follow-up vulnerability scans — don't assume a deployment succeeded.

---

## Challenges

- **Legacy systems** — older systems may no longer be supported by vendors (end-of-life), or critical business applications may depend on specific software versions that break if patched, leaving organizations stuck choosing between stability and security. *Mitigation:* isolate legacy systems via network segmentation and compensating controls (e.g., a web application firewall) when patching isn't possible.
- **Downtime concerns** — some patches require a service restart or system reboot, and organizations running 24/7 operations are reluctant to take systems offline. *Mitigation:* use rolling/staggered deployment across redundant systems so patching doesn't require full downtime.
- **Testing requirements** — thorough testing takes time, and rushing a patch to production risks breaking production systems, while delaying it risks exploitation. *Mitigation:* maintain a representative staging environment and automate regression testing to shorten the safe testing window.
- **Scale and complexity** — large organizations may have thousands of endpoints and dozens of applications with interdependencies (as Equifax discovered, patching one component required rebuilding many dependent applications). *Mitigation:* centralized, automated patch management platforms with dependency mapping.

---

## References

1. National Institute of Standards and Technology, Special Publication 800-40 (Guide to Enterprise Patch Management) — https://nvlpubs.nist.gov
2. CISA — https://www.cisa.gov
3. CVE Database (MITRE) — https://cve.mitre.org
4. TechFinitive, "WannaCry ransomware: lessons to learn" — https://www.techfinitive.com/features/lessons-to-be-learned-from-wannacry/
5. The Register, "Missed patch caused Equifax data breach" — https://www.theregister.com/2017/09/14/missed_patch_caused_equifax_data_breach/
6. Data Center Knowledge, "Equifax Says Unpatched Apache Struts Flaw Behind Massive Security Breach" — https://www.datacenterknowledge.com/data-breaches/equifax-says-unpatched-apache-struts-flaw-behind-massive-security-breach
