pipeline {
    agent any
    stages {
        stage('Initialize'){
            steps {
                script {
                    def dockerHome = tool 'myDocker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/admin') {
                        sh 'docker compose up -d backend .'
                        sh 'docker compose up -d queue .'
                        sh 'docker compose up -d db .'
                    }
                }
            }
        }
        stage('Run Services') {
            steps {
                script {
                    dir('/var/lib/jenkins/workspace/microservice_pipeline/admin') {
                        sh 'docker run -p 8000:8000 -v "$PWD":/app --name backend backend python manage.py runserver 0.0.0.0:8000'
                        sh 'docker run --name queue queue python -u consumer.py'
                        sh 'docker run -p 33066:3306 -v "$PWD/.dbdata":/var/lib/mysql --name db -e MYSQL_DATABASE=admin -e MYSQL_USER=root -e MYSQL_PASSWORD=root -e MYSQL_ROOT_PASSWORD=root db'
                    }
                }
            }
        }
    }
}



