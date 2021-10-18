# SCRIPT INSTALL ZABBIX 5 agent ON DEBIAN 11

ZABBIX VERSION: 5.0 LTS

OS DISTRIBUTION: DEBIAN

OS VERSION: 11(BULLSEYE)

DATABASE: MySQL

WEB SERVER: Apache

## Fast Install
Execute command
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/silvajhb/SIZ5D11/agent/master/script.sh)";
```

## 1. Install Zabbix repository
```shell
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-2+debian11_all.deb;
apt install ./zabbix-release_5.0-2+debian11_all.deb;
apt update;
```

## 2. Install Zabbix agent
```shell
apt install zabbix-agent -y;
```

## 3. configure Zabbix Agent
open file and edit line
```shell
vi /etc/zabbix/zabbix_agentd.conf
```
```
Server="Server-IP"
ServerActive="Server-IP"
Hostanme="Local-Hostname"
```

## 4. Install SUDO and UFW

```shell
apt install sudo ufw -y;
```

## 5. Firewall configuration
Open ports 10050, allow traffic Zabbix Agent.

UFW Firewall
```shell
sudo ufw allow 10050/tcp;
sudo ufw reload;
```

## 6. Start Zabbix server and agent processes
```shell
systemctl restart zabbix-agent;
systemctl enable  zabbix-agent;
systemctl start zabbix-agent;
systemctl status zabbix-agent;
```

### Read Also
[Quickstart guide](https://www.zabbix.com/documentation/5.0/manual/quickstart/login).

[Zabbix Documentation Agent](https://www.zabbix.com/documentation/5.0/manual/concepts/agent).
