pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "myapp:v1"
        DOCKER_REGISTRY = "dockerhub_username/myapp"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/username/repository.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean test'  // Modify for your tech stack (e.g., npm test, pytest, etc.)
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker tag $DOCKER_IMAGE $DOCKER_REGISTRY'
                    sh 'docker push $DOCKER_REGISTRY'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yaml'
            }
        }
    }
}
