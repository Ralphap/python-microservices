pipeline {
    agent {
        docker { 
            image 'jenkins/jenkins:lts' 
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('Build') {
            steps {
                script {
                    dir('/path/to/my/project') {
                        sh 'docker build -f Dockerfile -t backend .'
                        sh 'docker build -f Dockerfile -t queue .'
                        sh 'docker build -t db -f db-Dockerfile .'
                    }
                }
            }
        }
        stage('Run Services') {
            steps {
                script {
                    dir('/path/to/my/project') {
                        sh 'docker run -p 8000:8000 -v "$PWD":/app --name backend backend python manage.py runserver 0.0.0.0:8000'
                        sh 'docker run --name queue queue python -u consumer.py'
                        sh 'docker run -p 33066:3306 -v "$PWD/.dbdata":/var/lib/mysql --name db -e MYSQL_DATABASE=admin -e MYSQL_USER=root -e MYSQL_PASSWORD=root -e MYSQL_ROOT_PASSWORD=root db'
                    }
                }
            }
        }
    }
}



//GGGGGG