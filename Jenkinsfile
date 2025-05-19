pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'krtech26'
        DEV_IMAGE = 'react-site-app-dev'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/kamal261292/project-01-guvi.git'
            }
        }

        stage('DockerHub Credentials') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-hub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    echo "DockerHub credentials loaded"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh './build.sh'
            }
        }

        stage('Push Docker Image') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-hub-creds', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_HUB_USERNAME/$DEV_IMAGE:latest
                        docker logout
                    """
                }
            }
        }
    }
}
