pipeline {
    agent any
    
    environment {
        //Env Variables for Creds
        GITHUB_CREDENTIALS = credentials('github-creds')
        GITHUB_REPO = 'https://github.com/bigloumeanie/devopsProject.git'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'lacarbonaradev/devopsproject-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git url: "${DOCKER_IMAGE}", branch: 'main'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    // Run the Docker container and execute tests
                    docker.image("${DOCKER_IMAGE}").inside {
                        sh 'pytest tests/'
                    }
                }
            }
        }
        
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKERHUB_CREDENTIALS') {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker images
            sh 'docker rmi ${DOCKER_IMAGE}'
        }
    }
}
