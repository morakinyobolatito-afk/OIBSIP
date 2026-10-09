Track: OIBSIP Security Analyst Internship
Author: Morakinyo

Objective

Use Nikto to perform an automated vulnerability scan on a web server, analyse the results, and document identified security issues with recommended remediation steps.

Lab Setup

Machine: Kali Linux (VirtualBox)
Target: Local XAMPP/Apache server running DVWA at http://localhost
Scanned twice — once with DVWA security level set to Low, once set to Impossible, to compare results

What is Nikto?

Nikto is an open-source web server vulnerability scanner. It checks a web server for thousands of known issues, including outdated software versions, dangerous files or scripts, missing security headers, and default or insecure configurations. Unlike Nmap, which maps open ports and services across a network, Nikto focuses specifically on a single web server's configuration and content.

Installation

sudo apt install nikto -y

Scans Performed

	1.	Basic scan: nikto -h http://localhost -o nikto_scan_results.txt
	2.	Repeated with DVWA security level set to Impossible for comparison
	3.	SSL check attempted: nikto -h https://localhost -ssl — not applicable, since this server only runs HTTP (port 80), not HTTPS. No SSL/TLS service exists to scan, which is itself worth noting as a finding.

Findings by Severity

HIGH

	•	HTTP TRACE method enabled — makes the host vulnerable to Cross-Site Tracing (XST) attacks, which can be used to steal cookies/session data even from HttpOnly-protected cookies
	•	phpMyAdmin exposed and publicly reachable (/phpmyadmin/) — a database management interface with no IP restriction is a significant risk if exposed on a real/production server

MEDIUM

	•	Multiple outdated software versions detected: Apache 2.4.58, PHP 8.2.12, OpenSSL 1.1.1w, mod_perl 2.0.12, and Perl v5.34.1 are all behind current versions — outdated software is a common vector for known-CVE exploitation
	•	Directory indexing enabled on /webalizer/, /img/, and /icons/ — allows anyone to browse and list the contents of these folders directly, potentially exposing files not meant to be publicly listed

LOW / INFORMATIONAL

	•	Missing security headers: Content-Security-Policy, Referrer-Policy, Strict-Transport-Security, X-Content-Type-Options, and Permissions-Policy are all absent — these headers provide browser-level protections against clickjacking, MIME-sniffing attacks, and data leakage via referrers
	•	X-Frame-Options header noted as deprecated in favor of CSP's frame-ancestors directive
	•	Apache default files still present (/icons/README) — minor information disclosure about server defaults

Remediation Recommendations

	1.	Disable the HTTP TRACE method in Apache configuration (TraceEnable Off) to close the XST vulnerability
	2.	Restrict phpMyAdmin access to specific trusted IP addresses, or remove it from a production-facing server entirely
	3.	Update Apache, PHP, OpenSSL, mod_perl, and Perl to their current stable versions to close any known vulnerabilities tied to the outdated versions
	4.	Disable directory indexing (Options -Indexes in Apache config) across all web-accessible directories
	5.	Add the missing security headers at the web server or application level to harden the site against common browser-based attacks

What Nikto's Noisiness Means

Nikto is intentionally a "noisy" scanner — it sends a very large number of requests (7797 in this scan) designed to probe for the widest possible range of known issues, rather than trying to be subtle or evade detection. This makes it excellent for authorized vulnerability assessments where thoroughness matters, but unsuitable for covert reconnaissance, since any monitored network or intrusion detection system will easily notice this volume of requests.

Nikto vs Nmap

Nmap scans a network to discover live hosts, open ports, and running services across potentially many machines. Nikto instead takes one specific web server as its target and dives deep into that single application layer, checking for web-specific vulnerabilities, outdated software signatures, misconfigurations, and known-risky files. In a real assessment, Nmap is typically run first to discover that a web server exists, then Nikto is run against that discovered server for deeper web-layer analysis.

Ethics Note

This scan was performed exclusively against a local DVWA installation running on my own machine, with no external network exposure. Only scan web servers you own or have explicit written authorization to test.

Files

nikto_scan_results.txt — full scan output and findings
Screenshots of Nikto running on both Low and Impossible security settings
