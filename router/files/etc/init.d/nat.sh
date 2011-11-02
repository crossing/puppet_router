#!/bin/sh

/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables --table nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/sysctl net.ipv4.ip_forward=1
