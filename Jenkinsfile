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
        stage('React Build') {
        agent {
            docker {
                image 'python:3.9'
                args '-u root:root'
                reuseNode true
                dockerfile './Dockerfile'
            }
        }


            steps {
                script {
                    environment {
                        NPM_CONFIG_CACHE = "${WORKSPACE}/.npm"
                    }
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/react-crud') {
                        sh 'npm install'
                        sh 'apt update -y'
                        sh 'apt install python -y'
                        env.NODE_OPTIONS="--openssl-legacy-provider"
                        sh 'npm run build'
                        sh 'npm start'
                        sh 'pwd'
                        
                    }
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/admin'){
                    sh 'pwd'
                    sh 'ls'
                    sh 'python manage.py collectstatic --noinput'
                    }
                    
                }
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



