Task 8 — Capture Network Traffic with Wireshark

Track: OIBSIP Security Analyst Internship
Author: Morakinyo

Objective

Capture live network traffic using Wireshark, apply filters to isolate specific protocols, analyse packet contents, and document findings with security observations.

Lab Setup

Machine: Kali Linux (VirtualBox), interface eth0
Captured live traffic while browsing normally in Firefox (inside Kali) to generate HTTP, HTTPS, and DNS traffic

Capture Summary

A live capture of several minutes of traffic was taken on interface eth0, saved as wireshark_capture.pcap. Filters were then applied to isolate and analyse specific protocols.

HTTP Traffic (filter: http)

Found an unencrypted HTTP GET request:
GET /success.txt?ipv4 HTTP/1.1
Host: detectportal.firefox.com

followed by the server's plaintext response (HTTP/1.1 200 OK, text/plain). This is a captive-portal detection request Firefox sends automatically, but it demonstrates exactly how unencrypted HTTP traffic looks on the wire — every part of the request, including the host and path, is visible in cleartext.

DNS Traffic (filter: dns)

Captured numerous DNS queries and responses, including:

	•	content-signature-2.cdn.mozilla.net (A/AAAA)
	•	ads.mozilla.org (A/AAAA, with CNAME resolution)
	•	firefox.settings.services.mozilla.com
	•	safebrowsing.googleapis.com

Each query (sent to the local resolver at 172.20.10.1) was matched with a corresponding response, showing the standard DNS request/response pattern and how domain names resolve to IP addresses before a connection is made.

TCP Traffic and 3-Way Handshake (filter: tcp)

Identified a clean TCP three-way handshake between the local machine (10.0.2.15) and a remote server (34.149.226.178) on port 443:

	1.	SYN — packet 14: 10.0.2.15 to 34.149.226.178, Seq=0, Win=64240, MSS=1460 SACK_PERM
	2.	SYN, ACK — packet 29: 34.149.226.178 to 10.0.2.15, Seq=0 Ack=1 Win=65535 MSS=1460
	3.	ACK — packet 30: 10.0.2.15 to 34.149.226.178, Seq=1 Ack=1 Win=64240

This is the standard handshake every TCP connection performs before any application data is exchanged — the client proposes a connection (SYN), the server acknowledges and agrees (SYN-ACK), and the client confirms (ACK), after which data transfer begins (visible in the capture as the subsequent TLS Client Hello).

Also visible: several RST (reset) and FIN, ACK packets, showing connections being abruptly terminated or gracefully closed during the capture window.

Unencrypted Data Observed

The HTTP GET request to detectportal.firefox.com described above is the clearest example: the full request line, host header, and response body were all readable in plaintext within Wireshark, with no encryption protecting any part of the exchange.

Why Unencrypted HTTP Traffic Is Dangerous

When traffic travels over plain HTTP, anyone positioned to observe that traffic — on a shared Wi-Fi network, a compromised router, or via a Man-in-the-Middle attack — can read everything in the request and response: URLs visited, form data submitted, cookies, and any other content sent in cleartext. For login pages or anything handling sensitive data, this means credentials or personal information could be captured directly off the wire with no sophistication required beyond running a packet capture tool like Wireshark.

How HTTPS Prevents This

HTTPS wraps the same HTTP traffic inside a TLS-encrypted tunnel. Before any application data is sent, the client and server perform a TLS handshake (visible in this capture as "Client Hello", "Server Hello, Change Cipher Spec") to agree on encryption keys. Once established, all subsequent data is encrypted, so an observer capturing the same traffic only sees scrambled ciphertext ("Application Data" in Wireshark) rather than readable content — the URL path, headers, and body are no longer visible, only the fact that a connection exists and the destination IP/domain (via SNI).

Glossary

Packet — a single unit of data transmitted over a network, containing both the actual payload and header information (source, destination, protocol, etc.)
Protocol — an agreed-upon set of rules that defines how data is formatted and exchanged between devices (e.g., HTTP, DNS, TCP)
Port — a numbered endpoint on a device that identifies which specific service or application traffic is intended for (e.g., port 443 for HTTPS, port 53 for DNS)
Payload — the actual content/data being carried inside a packet, as opposed to the header information that wraps around it
Handshake — an initial exchange of messages between two devices to establish a connection and agree on communication parameters before real data transfer begins (e.g., the TCP three-way handshake)

Ethics Note

This capture was performed only on my own local machine's network interface, capturing my own traffic. Never capture traffic on networks you do not own or administer, including public Wi-Fi or shared/institutional networks, without explicit authorization.

Files

wireshark_capture.pcap — the exported packet capture
Screenshots of HTTP, DNS, and TCP filtered views, including the annotated 3-way handshake
