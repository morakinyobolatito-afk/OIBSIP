Task 1 — Basic Network Scanning with Nmap

Track: OIBSIP Security Analyst Internship
Author: Morakinyo

Objective

Perform a network scan to identify open ports and services running on a target machine using Nmap, and document the findings with security analysis.

Lab Setup

	•	Attacker/Scanner machine: Kali Linux (VirtualBox), IP 192.168.56.101
	•	Target machine: Metasploitable 2 (VirtualBox) — an intentionally vulnerable Linux VM, IP 192.168.56.102
	•	Network mode: VirtualBox Host-only Adapter, so both VMs communicate on an isolated private network with no internet exposure required

What is Nmap?

Nmap (Network Mapper) is a free, open-source tool used to discover hosts and services on a network by sending packets and analyzing the responses. It can identify which hosts are online, which ports are open on those hosts, what services and versions are running on those ports, and even attempt to fingerprint the target's operating system.

Why Network Scanning Matters

Network scanning is typically the first step in both offensive security testing and defensive security auditing. From an attacker's perspective, it reveals potential entry points. From a defender's perspective, it reveals exactly what an attacker would see — an organization should regularly scan its own systems to find and close unnecessary or vulnerable open ports before someone else finds them first.

Installation

Nmap comes pre-installed on Kali Linux. To verify or install it manually on a Debian/Ubuntu-based system:

sudo apt update
sudo apt install nmap -y
nmap --version

Scans Performed

	1.	Basic scan: nmap 192.168.56.102 — identifies open ports
	2.	Service version scan: nmap -sV 192.168.56.102 — identifies the specific service and version running on each open port
	3.	OS detection scan: sudo nmap -O 192.168.56.102 — fingerprints the target's operating system

Full output and a detailed port-by-port security analysis are in nmap_scan_results.txt.

Key Findings

23 open TCP ports were identified, including several with known, documented backdoors (vsftpd 2.3.4, ProFTPD 1.3.1, UnrealIRCd, and a bind shell on port 1524) — this is expected, as Metasploitable 2 is intentionally built as a vulnerable training target.

⚠️ Ethics Note

This scan was performed exclusively against a local, intentionally vulnerable VM (Metasploitable 2) that I own and control, running in an isolated Host-only virtual network with no connection to any external or production system. Scanning systems you do not own or have explicit permission to test is illegal in most jurisdictions. Always obtain written authorization before scanning any network you do not personally own.

Files

	•	nmap_scan_results.txt — full scan output (basic, service version, OS detection) plus a port-by-port security analysis
	•	Screenshots of terminal output (see repo)








