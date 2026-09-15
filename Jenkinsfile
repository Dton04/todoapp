pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKER_HUB_USERNAME = 'dton04'
        IMAGE_BACKEND = "${DOCKER_HUB_USERNAME}/todo-backend"
        IMAGE_FRONTEND = "${DOCKER_HUB_USERNAME}/todo-frontend"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install & Test') {
            steps {
                script {
                    echo 'Testing Backend...'
                    dir('backend') {
                        sh 'npm install'
                    }
                    echo 'Testing Frontend...'
                    dir('frontend') {
                        sh 'npm install'
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo 'Building Backend Image...'
                    dockerBackend = docker.build("${IMAGE_BACKEND}:${env.BUILD_ID}", "./backend")
                    dockerBackendLatest = docker.build("${IMAGE_BACKEND}:latest", "./backend")

                    echo 'Building Frontend Image...'
                    dockerFrontend = docker.build("${IMAGE_FRONTEND}:${env.BUILD_ID}", "./frontend")
                    dockerFrontendLatest = docker.build("${IMAGE_FRONTEND}:latest", "./frontend")
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS_ID}") {
                        echo 'Pushing Backend Image...'
                        dockerBackend.push()
                        dockerBackendLatest.push()

                        echo 'Pushing Frontend Image...'
                        dockerFrontend.push()
                        dockerFrontendLatest.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying Application...'
                    // Example deployment using ssh-agent or sshagent plugin:
                    // sshagent(['server-ssh-credentials-id']) {
                    //     sh 'ssh -o StrictHostKeyChecking=no user@yourserver.com "cd /app/mern-todo-app && docker-compose pull && docker-compose up -d"'
                    // }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline successfully completed!'
        }
        failure {
            echo 'Pipeline failed. Please check console logs.'
        }
    }
}
