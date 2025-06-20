#!/bin/bash
set -e

# Update system and install base tools
apt update -y
apt install -y openjdk-17-jdk wget gnupg unzip curl git maven nodejs npm

# Install Jenkins (latest LTS)
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install -y jenkins
systemctl enable jenkins
systemctl start jenkins

# Install Apache Tomcat 9.0.106
cd /opt
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.106/bin/apache-tomcat-9.0.106.tar.gz
tar xzvf apache-tomcat-9.0.106.tar.gz
mv apache-tomcat-9.0.106 tomcat9
chmod +x tomcat9/bin/*.sh
./tomcat9/bin/startup.sh

# Install SonarScanner CLI (latest version)
cd /opt
SONAR_VERSION="5.0.1.3006"
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_VERSION}-linux.zip
unzip sonar-scanner-cli-${SONAR_VERSION}-linux.zip
mv sonar-scanner-${SONAR_VERSION}-linux sonar-scanner
ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

# Done
