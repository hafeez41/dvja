pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
    }

    environment {
        ARTIFACT_NAME = "dvja.war"
    }

    tools {
        maven 'Maven_3' // Assumes "Maven_3" is set up in Jenkins global tools
    }

    stages {
        stage('Source') {
            steps {
                git 'https://github.com/hafeez41/dvja.git'
            }
        }

        stage('Build') {
    steps {
        sh '''
            # Fail if no pom.xml
            if [ ! -f pom.xml ]; then
              echo "ERROR: pom.xml not found. Cannot build."
              exit 1
            fi

            # Resolve dependencies
            mvn dependency:go-offline -B

            # Compile source code
            mvn clean compile -B

            # Package into WAR (without running tests here)
            mvn package -DskipTests -B
        '''
    }
}


        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Placeholder for SonarQube or other static analysis'
            }
        }

        stage('Artifact Upload') {
            steps {
                echo 'Placeholder for JFrog Artifactory upload'
            }
        }

        stage('Deploy (EC2)') {
            steps {
                sh "cp target/${env.ARTIFACT_NAME} /opt/tomcat9/webapps/"
            }
        }
    }
}
