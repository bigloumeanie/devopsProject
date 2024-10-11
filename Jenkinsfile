pipeline {
    agent any
    
    environment {
        //Env Variables for Creds
        GITHUB_CREDENTIALS = credentials('github-credentials')
        GITHUB_REPO = 'https://github.com/bigloumeanie/devopsProject.git'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'lacarbonaradev/devopsproject-app'
    }
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    git url: 'https://github.com/yourusername/your-repo.git',
                        branch: 'main',
                        credentialsId: 'github-credentials'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKERHUB_CREDENTIALS') {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker rmi ${DOCKER_IMAGE}:latest'
        }
    }
}