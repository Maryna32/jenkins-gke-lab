pipeline {
    agent any
    environment {
        PROJECT_ID = 'cloud-lab3-3003'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-a'
        CREDENTIALS_ID = 'gcp-key'
        DOCKER_CREDS = 'docker-hub-key'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build & Push image') {
            steps {
                script {
                    def imageTag = "v${env.BUILD_NUMBER}"
                    docker.withRegistry('', DOCKER_CREDS) {
                        def app = docker.build("maryna334/pipeline:${imageTag}")
                        app.push()
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy to K8s') {
            steps {
                script {
                    sh "sed -i 's|image: maryna334/pipeline:.*|image: maryna334/pipeline:v${env.BUILD_NUMBER}|g' deployment.yaml"
                    
                    step([$class: 'KubernetesEngineBuilder', 
                          projectId: env.PROJECT_ID, 
                          clusterName: env.CLUSTER_NAME, 
                          location: env.LOCATION, 
                          manifestPattern: 'deployment.yaml', 
                          credentialsId: env.CREDENTIALS_ID, 
                          verifyDeployments: true])
                }
            }
        }
    }
}
