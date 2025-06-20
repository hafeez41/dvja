pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
    }

    environment {
    ARTIFACT_NAME = "dvja-1.0-SNAPSHOT.war"
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
                    if [ ! -f pom.xml ]; then
                      echo "ERROR: pom.xml not found"
                      exit 1
                    fi

                    mvn dependency:go-offline -B
                    mvn clean compile -B
                    mvn package -DskipTests -B
                '''
            }
        }
 
        stage('Test') {
            steps {
                sh 'mvn test -B'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Placeholder for SonarQube'
            }
        }

        stage('Artifact Upload') {
            steps {
                echo 'Placeholder for Artifactory'
            }
        }

        stage('Deploy (EC2)') {
            steps {
                sh "cp target/${env.ARTIFACT_NAME} /opt/tomcat9/webapps/"
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: "target/${env.ARTIFACT_NAME}", fingerprint: true
        }
        failure {
            echo "Build failed. Check logs."
        }
    }
}
