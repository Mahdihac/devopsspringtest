pipeline {
    agent any

    tools {
        maven 'Maven_3'
        jdk 'Java_17'
    }

    environment {
        SONARQUBE_SERVER = 'sonar'
        DOCKER_IMAGE = 'devopsspringapp'
        VERSION = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Mahdihac/devopsspringtest.git'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${env.SONARQUBE_SERVER}") {
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${VERSION} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:${VERSION}"
                }
            }
        }
    }
}
