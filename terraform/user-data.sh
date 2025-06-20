#!/bin/bash
set -e

# Update system
apt update -y
apt install -y openjdk-17-jdk wget gnupg unzip curl

# Install Jenkins (official method)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# Install Tomcat 9 (latest link)
cd /opt
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.106/bin/apache-tomcat-9.0.106.tar.gz
tar xzvf apache-tomcat-9.0.106.tar.gz
mv apache-tomcat-9.0.106 tomcat9
chmod +x tomcat9/bin/*.sh
./tomcat9/bin/startup.sh
