#!/bin/bash
# UFW Firewall Configuration Script
# Author: Morakinyo — OIBSIP Security Analyst Task 2

sudo ufw enable
sudo ufw allow ssh
sudo ufw deny http
sudo ufw allow https
sudo ufw deny 23
sudo ufw status verbose
