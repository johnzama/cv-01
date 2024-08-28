pipeline {
    agent any

    tools {
        maven 'Maven 3.8.5' // Maven tool configured in Jenkins
        jdk 'Java 11'       // JDK tool configured in Jenkins
    }

    environment {
        SONARQUBE_SERVER = 'resume-sonar'  // SonarQube server configured in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/johnzama/cv-01.git'
            }
        }

        stage('Code Quality Analysis') {
            steps {
                script {
                    withSonarQubeEnv(SONARQUBE_SERVER) {
                        sh 'sonar-scanner -Dsonar.projectKey=resume_project -Dsonar.sources=. -Dsonar.host.url=http://your-sonarqube-url'
                    }
                }
            }
        }
        
        stage('Build Application') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "bebop"
                    sh "docker build -t ${imageName} ."
                }
            }
        }

        stage('Security Scan') {
            steps {
                script {
                    sh 'trivy image bebop'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform init'
                    sh 'terraform validate'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    def containerName = "resume-container"
                    sh "docker run -d --name ${containerName} -p 8081:80 bebop"
                }
            }
        }

        stage('Configuration Management with Ansible') {
            steps {
                script {
                    sh 'ansible-playbook -i inventory.ini playbook.yml'
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

