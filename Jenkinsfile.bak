pipeline {
    agent {
        docker {
            image 'dminus251/jenkins-docker-agent:latest'
        }
    }
    stages {
        stage('Compile') {
            steps {
                sh './gradlew compileJava'
            }
        }
        stage('Unit Test') {
            steps {
                sh './gradlew test'
            }
        }
        stage('Code Coverage') {
            steps {
                sh './gradlew jacocoTestReport'
                sh './gradlew jacocoTestCoverageVerification'
            }
        }
        stage('Static Code Analysis') {
            steps {
                sh './gradlew checkstyleMain'
            }
        }
        stage('Build Jar') {
            steps {
                sh './gradlew build'
            }
        }
        stage('Verify Build Output') {
            steps {
                sh 'ls -la build/libs/'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    // Ensure Docker is available
                    sh 'docker --version'

                    // Move the JAR file to the root of the build context
                    sh 'cp build/libs/calculator-0.0.1-SNAPSHOT.jar .'

                    // Build Docker image
                    sh 'docker build -t dminus251/calculator:2 .'
                }
            }
        }
    }
}

