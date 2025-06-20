pipeline {
    agent any

    environment {
        ARTIFACT_NAME = "dvja.war"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/dvja.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // This requires SonarQube to be configured in Jenkins
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: "target/${env.ARTIFACT_NAME}", fingerprint: true
            }
        }

        stage('Upload to Artifactory') {
            steps {
                echo 'Upload to JFrog Artifactory would go here.'
                // Will be implemented once JFrog is configured
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
