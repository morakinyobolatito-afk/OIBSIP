Task 3 — SQL Injection on DVWA (Low Security)

Track: OIBSIP Security Analyst Internship
Author: Morakinyo

Objective

Demonstrate a classic SQL Injection vulnerability by exploiting the login/query form of DVWA (Damn Vulnerable Web Application) on its Low security setting, and document the attack with an explanation of how it works and how to prevent it.

Lab Setup

Machine: Kali Linux (VirtualBox)
Stack: XAMPP (Apache, MySQL, PHP) installed locally via /opt/lampp
Target application: DVWA, cloned from the official GitHub repo and installed at /opt/lampp/htdocs/dvwa
Accessed entirely over localhost — no external network exposure

What is SQL Injection?

SQL Injection is a web application vulnerability where untrusted user input is inserted directly into a SQL query without proper sanitization or parameterization. This allows an attacker to alter the structure and logic of the underlying database query, potentially exposing, modifying, or deleting data the application was never meant to reveal.

Setup Steps

	1.	Installed XAMPP for Linux (Apache, MySQL, PHP)
	2.	Cloned DVWA into /opt/lampp/htdocs/dvwa
	3.	Configured config/config.inc.php with database credentials (db_user: root, db_password: blank)
	4.	Set folder permissions with chmod -R 777
	5.	Ran DVWA's database setup via setup.php — "Create / Reset Database"
	6.	Logged in with default credentials (admin / password)
	7.	Set DVWA Security Level to Low

Why This Payload Works

DVWA's Low-security SQL Injection module builds its database query by directly concatenating raw user input into the SQL string, with no input sanitization, escaping, or use of parameterized queries/prepared statements. This means any input containing SQL syntax characters (like a single quote) can break out of the intended query structure and inject new logic.

Payloads Used

Two different payloads were tested — full detail, exact URLs, and output for each is logged in sql_injection_notes.md:

	1.	' OR '1'='1 — classic authentication/filter bypass payload that turns the query's WHERE clause into an always-true condition
	2.	%' or '0'='0 — a variant using a wildcard-style prefix, which produced the same result, confirming the vulnerability isn't tied to one specific payload syntax

Both payloads caused the application to return all five user records in the database instead of the single record a legitimate query would return.

What Data Was Exposed

The full users table contents — first and last names of every registered DVWA demo account (admin, Gordon Brown, Hack Me, Pablo Picasso, Bob Smith). In a real-world application, the same flaw could expose far more sensitive columns (emails, password hashes, personal data) depending on what the query selects.

How a Developer Would Fix This

	1.	Use parameterized queries / prepared statements — the single most effective fix. Instead of building SQL strings by concatenating user input, use placeholders and pass user input as data, never as part of the query structure.
	2.	Input validation — enforce that fields expecting a numeric ID only accept integers, rejecting anything containing quotes or SQL keywords.
	3.	Least-privilege database accounts — the application's database user should only have the minimum permissions it needs, limiting the damage even if injection occurs.
	4.	Web Application Firewall (WAF) — as a defense-in-depth layer, not a replacement for fixing the code itself.

Ethics Note

This exploitation was performed exclusively against DVWA running locally on my own machine, in an intentionally vulnerable, isolated environment built for this purpose. Never attempt SQL injection or any other exploitation technique against a real website, application, or system without explicit written authorization.

Files

sql_injection_notes.md — detailed payload log with full URLs, raw output, and explanation
Screenshots of each injection attempt and its output
