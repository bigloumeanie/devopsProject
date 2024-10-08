pipeline {
    agent any
    
    environment {
        //Env Variables for Creds
        GITHUB_CREDENTIALS = credentials('github-credentials')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = 'devopsProject'
    }
    
    stages {
        // Clone Github Repo using Github Creds
        stage('Checkout Code') {
            steps {
                script {
                    // Checkout code from github using Github Creds
                    git url: 'https://github.com/bigloumeanie/devopsProject.git',
                    branch: 'main',
                    credentialsId: 'github-credentials'
                }
            }
        }
        
        // Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile from the repo
                    docker.build('devopsProject:latest')
                }
            }
        }
        
        // Run any tests if necessary
        stage('Run Unit Tests') {
            steps {
                script {
                    // Run tests in docker container
                    docker.image('devopsProject:latest').inside {
                        //sh 'pytest tests/'
                        sh 'echo "Running Sample Tests...'
                    }
                }
            }
        }
        
        // Push Docker Image > DockerHub using dockerhub-creds
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    // Log into dockerhub and push image
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKERHUB_CREDENTIALS') {
                        docker.image('devopsProject:latest').push()
                    }
                }
            }
        }
    }
    
    // Cleanup Docker Images after Job is done
    post {
        always {
            // Clean up docker image after pipeline is done
            sh 'docker rmi ${DOCKER_IMAGE}:latest'
        }
    }
}