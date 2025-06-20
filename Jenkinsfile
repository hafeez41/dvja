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
        sh '''
            MAVEN_OPTS="-Xmx256m" \
            mvn dependency:go-offline -Dmaven.compiler.fork=false || true

            MAVEN_OPTS="-Xmx256m" \
            mvn package -DskipTests -Dmaven.compiler.fork=false
        '''
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
