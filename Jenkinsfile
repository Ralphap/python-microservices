pipeline {
    agent any
    stages {
        stage('Login to Azure') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: '4da4a74e-271e-41fa-982f-924ade10f5dc')]) {
                    sh "az login --service-principal -u ${AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID}"
                }
            }
        }
        stage('Verify Tooling'){
            steps {
                sh '''
                docker version
                '''
            }
        }
        stage('Initialize'){
            steps {
                script {
                    def dockerHome = tool 'myDocker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myimage -f ./Dockerfile .'
            }
        }
        stage('React Build') {
            steps{
                sh 'docker run -d -p 80:3000 myimage'
            }
        }


        stage('Build Admin') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/admin') {
                        sh 'docker-compose up -d db'
                        sh "sleep 5"
                        sh 'docker-compose up'
                    }
                }
            }
        }
        stage('Build Main') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/main') {
                        sh 'docker-compose up -d db'
                        sh "sleep 5"
                        sh 'docker-compose up'
                    }
                }
            }
        }
    }
}





