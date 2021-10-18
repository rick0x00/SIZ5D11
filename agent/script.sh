#!/bin/bash

echo "SCRIPT INSTALL ZABBIX 5 agent ON DEBIAN 11";

echo "ZABBIX VERSION: 5.0 LTS";

echo "OS DISTRIBUTION: DEBIAN";

echo "OS VERSION: 11(BULLSEYE)";

echo "DATABASE: MySQL";

echo "WEB SERVER: Apache";


echo "1. Install Zabbix repository";
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-2+debian11_all.deb;
apt install ./zabbix-release_5.0-2+debian11_all.deb;
apt update;


echo "2. Install Zabbix agent";
apt install zabbix-agent -y;

echo "3. configure Zabbix Agent";
ip="192.168.0.1";
cp /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bkp
sed 's/Server=127.0.0.1/Server='$ip'/g' /etc/zabbix/zabbix_agentd.conf.bkp > /etc/zabbix/zabbix_agentd.conf;
sed 's/ServerActive=127.0.0.1/ServerActive='$ip'/g' /etc/zabbix/zabbix_agentd.conf;
sed 's/Hostname='$hostaname'/Hostname='$ip'/g' /etc/zabbix/zabbix_agentd.conf;
vi /etc/zabbix/zabbix_agentd.conf;

```
Server="Server-IP"
ServerActive="Server-IP"
Hostanme="Local-Hostname"
```
echo "4. Install SUDO and UFW";
apt install sudo ufw -y;


echo "5. Firewall configuration";
echo "Open ports 10050, allow traffic Zabbix Agent.";

sudo ufw allow 10050/tcp;
sudo ufw reload;


echo "6. Start Zabbix server and agent processes";

systemctl restart zabbix-agent;
systemctl enable  zabbix-agent;
systemctl start zabbix-agent;
systemctl status zabbix-agent;
