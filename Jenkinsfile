pipeline {
    agent any

    options {
        timeout(time: 10, unit: 'MINUTES')
    }

    environment {
        ARTIFACT_NAME = "dvja.war"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hafeez41/dvja.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests -Dmaven.compiler.fork=false'
            }
        }

        // Optional: Keep test stage separate for now
        stage('Unit Test') {
            steps {
                sh 'mvn test -Dmaven.compiler.fork=false'
            }
        }

        // SonarQube skipped for now (not set up)
/*
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: "target/${env.ARTIFACT_NAME}", fingerprint: true
            }
        }
*/
        stage('Upload to Artifactory') {
            steps {
                echo 'Upload to JFrog Artifactory would go here.'
            }
        }

        stage('Deploy to EC2') {
            steps {
                echo 'Deploy WAR to Tomcat on EC2 (same server)'
                sh """
                cp target/${env.ARTIFACT_NAME} /opt/tomcat9/webapps/
                """
            }
        }
    }
}
