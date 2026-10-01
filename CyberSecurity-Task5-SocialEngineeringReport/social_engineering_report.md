# Social Engineering Attacks

**Author:** Morakinyo
**Track:** OIBSIP — Security Analyst
**Task:** Task 5 — Research Report: Social Engineering Attacks

---

## Introduction

Social engineering is the manipulation of people, rather than systems, into giving up confidential information or taking an action that compromises security. It is consistently ranked among the most effective attack vectors because it bypasses technical controls entirely — a firewall cannot stop an employee from trusting a convincing phone call or clicking a well-crafted email. Industry breach reports have repeatedly found that a large majority of successful breaches involve a human element, whether that's a phishing click, a social-engineered phone call, or an employee handing over credentials to someone impersonating IT support. This report covers three core techniques — phishing, pretexting, and baiting — plus quid pro quo as a bonus category, with real-world case studies and concrete prevention guidance for each.

---

## 1. Phishing

**Types:**
- **Spear phishing** — a targeted email aimed at a specific individual or small group, using personal or organizational details to appear credible.
- **Whaling** — spear phishing aimed specifically at senior executives (the "big fish") to authorize large transfers or release sensitive data.
- **Vishing** — voice phishing, typically a phone call impersonating a bank, IT support, or government agency.
- **Smishing** — phishing delivered via SMS text message, often with a malicious link.

**How it works:**
The attacker crafts a message that appears to come from a trusted source — a colleague, bank, or well-known brand — and creates urgency or curiosity to get the victim to click a link, open an attachment, or enter credentials on a fake login page.

**Real-world case study:**
In March 2011, RSA Security employees received an email titled "2011 Recruitment Plan" with an Excel attachment. Opening it triggered a zero-day Adobe Flash exploit that installed a Poison Ivy remote-access tool, giving attackers a foothold inside RSA's network. The attackers used that access to steal information related to RSA's SecurID two-factor authentication tokens — used by an estimated 250 million people at the time — forcing RSA to replace roughly 40 million tokens for customers worldwide at significant cost.

**Prevention recommendations:**
1. Deploy email filtering and attachment sandboxing to catch malicious payloads before they reach inboxes.
2. Train staff to verify unexpected attachments or requests through a second channel (e.g., a phone call) before acting.
3. Enforce multi-factor authentication so a single stolen credential isn't enough for account takeover.
4. Run regular phishing simulation exercises to build and measure employee awareness.

---

## 2. Pretexting

**How it works:**
Pretexting involves fabricating a believable scenario or identity — a "pretext" — to persuade a victim to hand over information or access. Unlike phishing's broad net, pretexting is usually built on reconnaissance: the attacker gathers details about the target's job, coworkers, or organization (often from social media or prior breaches) to make the false scenario convincing, then builds rapport over one or more interactions, commonly by impersonating IT support, a vendor, or an executive.

**Real-world case study:**
In September 2023, hotel and casino operator MGM Resorts International suffered a major breach that began with a pretexting attack: attackers called the company's IT help desk, impersonating an employee whose information they had found on LinkedIn, and convinced the help desk to reset credentials and grant access. That initial social-engineered access cascaded into a much larger ransomware and systems outage incident affecting hotel and casino operations.

**Prevention measures:**
1. Require strict identity verification procedures at help desks before any password reset or access change (e.g., callback to a known number, manager approval).
2. Limit how much organizational and personal information employees share publicly on social media.
3. Train staff — especially help desk and support personnel — to recognize pressure tactics and urgent, unverified requests.

---

## 3. Baiting

**How it works:**
Baiting lures victims with the promise of something enticing — physical or digital — to get them to compromise their own security. The classic physical form is leaving infected USB drives in a parking lot or lobby labeled with something tempting (e.g., "Payroll" or "Confidential"), counting on curiosity to make someone plug it into a work computer. The digital equivalent is fake downloads: pirated software, "free" movie or game downloads, or fake software updates bundled with malware.

**Real-world case study:**
A widely cited controlled study by researchers (covered by Google's security team and multiple university studies) dropped nearly 300 USB drives across a university campus; researchers found that the large majority were picked up, and roughly half of those were plugged into a computer and had their contents opened — demonstrating how effective simple curiosity-based baiting is even without any targeting of specific individuals.

**Prevention measures:**
1. Disable or restrict USB autorun/autoplay on corporate endpoints, and use endpoint protection to scan removable media automatically.
2. Train employees never to plug in found or unsolicited removable media, and to report it to IT/security instead.
3. Block access to untrusted download sources and pirated software at the network level.

---

## 4. Quid Pro Quo *(bonus)*

**Explanation:**
Quid pro quo attacks offer a service or benefit in exchange for information or access — for example, an attacker calling random employees claiming to be from IT support offering to "fix" a (nonexistent) problem, and asking the employee to disable antivirus or provide login credentials in return for the "help." Unlike baiting, which dangles an item, quid pro quo dangles a service or favor.

**Prevention:**
Train employees that legitimate IT support does not cold-call asking for credentials or remote access, and route all support requests through verified, official channels only.

---

## Comparison Table

| Attack Type | Primary Target | Psychological Lever Exploited | Best Countermeasure |
|---|---|---|---|
| Phishing | Any employee with an inbox/phone | Urgency, authority, fear | MFA + email filtering + simulated phishing training |
| Pretexting | Help desk, support staff, assistants | Trust, authority, helpfulness | Strict identity verification procedures |
| Baiting | Anyone with physical/network access | Curiosity, greed | Disable autorun + endpoint scanning + awareness training |
| Quid Pro Quo | Employees needing IT help | Reciprocity, desire for a quick fix | Verify all support requests through official channels |

---

## Organizational Recommendations: Employee Security Awareness Training Checklist

1. Run mandatory, recurring security awareness training for all employees — not a one-time onboarding event.
2. Conduct regular simulated phishing and vishing exercises, with feedback (not punishment) for those who fall for them.
3. Establish and publicize a clear, no-blame reporting channel for suspicious emails, calls, or found devices.
4. Enforce strict verification procedures for any request involving credentials, access changes, or fund transfers.
5. Review and limit how much sensitive organizational information (org charts, job titles, vendor relationships) is publicly discoverable on social media and the company website.

---

## References

1. Security Boulevard, "The Top Ten Most Famous Social Engineering Attacks" — https://securityboulevard.com/2018/07/the-top-ten-most-famous-social-engineering-attacks/
2. Check Point Software, "Software-defined Protection — RSA Case Study" — https://sc1.checkpoint.com/www/ebooks/sdp/files/assets/basic-html/page32.html
3. Carnegie Mellon University ISO, "Social Engineering: Pretexting and Impersonation" — https://www.cmu.edu/iso/news/2020/pretexting.html
4. Proofpoint, "What Is Pretexting?" — https://www.proofpoint.com/us/threat-reference/pretexting
5. CISA, Social Engineering guidance — https://www.cisa.gov
6. SANS Institute Reading Room — https://www.sans.org/reading-room
