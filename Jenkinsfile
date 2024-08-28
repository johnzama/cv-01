pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/johnzama/cv-01.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "bebop"  // Use your existing Docker image name
                    sh "docker build -t ${imageName} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    def containerName = "resume-container"
                    sh "docker run -d --name ${containerName} -p 8081:80 bebop" // Map port 8081 on the host to port 80 in the container
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker stop resume-container || true'
            sh 'docker rm resume-container || true'
        }
    }
}

