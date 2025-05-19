pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'krtech'
        DEV_IMAGE = 'react-site-app-dev'
        
    }

    triggers {
        pollSCM('* * * *') // optional if webhook is set up
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/kamal261292/project-01-guvi.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_HUB_USERNAME/$DEV_IMAGE:latest ."
                }
            }
        

        stage('Push Docker Image') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'master'
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_HUB_USER" --password-stdin
                        docker push $DOCKER_HUB_USER/$DEV_IMAGE:latest
                        docker logout
                    """
                }
            }
        }
    }
}
