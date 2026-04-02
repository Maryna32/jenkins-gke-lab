pipeline {
agent any
    environment {
   	 PROJECT_ID = 'cloud-lab3-3003'
            	CLUSTER_NAME = 'cluster-1'
            	LOCATION = 'us-central1-a'
            	CREDENTIALS_ID = 'gcp-key'
    }
    stages {
    	stage('Checkout') {
   	 	steps {
   		 	checkout scm
   	 	}
    	}
    	stage('Build image') {
   	 	steps {
   		 	script {
   			 	app = docker.build("maryna334/pipeline:${env.BUILD_ID}")
   		  	}
   						 	 
   	 	}
    	}
       	stage('Deploy to K8s') {
            steps {
                echo "Deployment started ..."
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
