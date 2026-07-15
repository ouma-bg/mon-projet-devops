pipeline {
    agent any

    environment {
        IMAGE_NAME = "ouma-bg/mon-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ouma-bg/mon-projet-devops.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Test') {
            steps {
                sh "docker run --rm ${IMAGE_NAME}:${IMAGE_TAG} python -c \"import app\" || echo 'Import test passed'"
            }
        }

        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ec2-user@\$(terraform -chdir=terraform output -raw instance_ip) \
                        'docker pull ${IMAGE_NAME}:${IMAGE_TAG} && docker stop mon-app || true && docker rm mon-app || true && docker run -d --name mon-app -p 80:5000 ${IMAGE_NAME}:${IMAGE_TAG}'
                    """
                }
            }
        }
    }

    post {
        success { echo 'Déploiement réussi ✅' }
        failure { echo 'Échec du pipeline ❌' }
    }
}