pipeline {
    agent any

    environment {
        DEV_IMAGE = 'krtech26/react-site-app-dev:dev'
        PROD_IMAGE = 'krtech26/react-site-app-prod:prod'
        DOCKER_CREDENTIALS_ID = 'Docker-hub-creds'
    }

    triggers {
        pollSCM('* * * * *') // optional if webhook is set up
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/kamal261292/project-01-guvi.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    BRANCH_NAME = env.BRANCH_NAME ?: sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()

                    if (BRANCH_NAME == 'dev') {
                        IMAGE = DEV_IMAGE
                    } else if (BRANCH_NAME == 'master') {
                        IMAGE = PROD_IMAGE
                    } else {
                        error("This pipeline only supports 'dev' and 'master' branches.")
                    }

                    sh "docker build -t ${IMAGE} ."
                }
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
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE}
                        docker logout
                    """
                }
            }
        }
    }
}
