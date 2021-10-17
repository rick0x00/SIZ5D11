# SCRIPT INSTALL ZABBIX 5 DEBIAN 11

ZABBIX VERSION: 5.0 LTS

OS DISTRIBUTION: DEBIAN

OS VERSION: 11(BULLSEYE)

DATABASE: MySQL

WEB SERVER: Apache

## Fast Install
Execute command
```shell
sh -c "$(wget -O- https://raw.githubusercontent.com/silvajhb/SIZ5D11/master/script.sh)";
```

## 1. Install Zabbix repository
```shell
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-2+debian11_all.deb;
dpkg -i zabbix-release_5.0-2+debian11_all.deb;
apt update;
```

## 2. Install Zabbix server, frontend, agent
```shell
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent -y;
```

## 3. Install and configure MariaDB
```shell
apt install mariadb-server mariadb-client -y;
mysql_secure_installation;
```

## 4. Create initial database
```shell
mysql -u root -p;
# insert password or press enter;
```
Run the following on your database host.
```mysql
mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> show databases;
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> quit;
```

```shell
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -u zabbix -p zabbix;
```
## 5. Configure the database for Zabbix server

Edit file and uncomment corresponding line.
```shell
vi /etc/zabbix/zabbix_server.conf;
```
```
DBPassword=password
```
## 6. Configure PHP for Zabbix frontend

Edit file, uncomment and set the right timezone.
```shell
vi /etc/zabbix/apache.conf;
```
```
php_value date.timezone America/Maceio
```

## 7. Config Selinux

edit the file and replace the line.
```shell
vi /etc/selinux/config
```
find
```
SELINUX=enforcing
```
replase with
```
SELINUX=disabled
```
## 7. Firewall configuration
Open ports 80 and 443, allow traffic Zabbix web GUI and Apache server.

UFW Firewall
```shell
ufw allow 80/tcp;
ufw allow 443/tcp;
ufw reload;
```

IpTables Firewall
```shell
iptables -I INPUT -p tcp --dport 80 -j ACCEPT;
iptables -I INPUT -p tcp --dport 443 -j ACCEPT;
```
or
```shell
iptables -A INPUT -p tcp --dport 80 -j ACCEPT;
iptables -A INPUT -p tcp --dport 443 -j ACCEPT;
```

## 8. Start Zabbix server and agent processes
```shell
systemctl restart zabbix-server zabbix-agent apache2 mariadb;
systemctl enable zabbix-server zabbix-agent apache2 mariadb;
systemctl start zabbix-server zabbix-agent apache2 mariadb;
systemctl status zabbix-server zabbix-agent apache2 mariadb;
```

## 9. Configure Zabbix frontend
Connect to your newly installed Zabbix frontend: http://server_ip_or_name/zabbix
Follow steps described in Zabbix documentation: [Installing frontend](https://www.zabbix.com/documentation/5.0/manual/installation/install#installing_frontend)

### Read Also
[Quickstart guide](https://www.zabbix.com/documentation/5.0/manual/quickstart/login).

[Video Zabbix server installation explained](https://www.youtube.com/embed/yYmkFf3AEBo?autoplay=1).

[Zabbix basic concepts](https://www.youtube.com/embed/7inJAmqyc0g?autoplay=1).
