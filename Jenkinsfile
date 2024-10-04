pipeline {
    agent any
    
    environment {
        //Env Variables for Creds
        GITHUB_CREDENTIALS = credentials('github-creds')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_IMAGE = 'llacarbonaradev/flask-app'
    }
    
    stages {
        // Clone Github Repo using Github Creds
        stage('Checkout Code') {
            steps {
                script {
                    git url: 'https://github.com/llacarbonaradev/devopsProject.git',
                    branch: 'main',
                    credentialsId: 'github-creds'
                }
            }
        }
        
        // Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }
        
        // Run any tests if necessary
        stage('Run Unit Tests') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:latest").inside {
                        sh 'pytest tests/'
                    }
                }
            }
        }
        
        // Push Docker Image > DockerHub using dockerhub-creds
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
    
    // Cleanup Docker Images after Job is done
    post {
        always {
            sh 'docker rmi ${DOCKER_IMAGE}:latest'
        }
    }
}