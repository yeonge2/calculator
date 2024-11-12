pipeline {
    agent {
	docker {
		image 'dminus251/jenkins-docker-agent:using_socket'
		args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
                label 'docker-node-agent'
        }
    }
    environment {
        DOCKER_CREDENTIALS_ID = 'dminus251' // 저장한 자격 증명의 ID를 입력합니다.
    }
    stages {
        stage('Check Docker Installation') {
            steps {
                script {
                    sh 'which docker'
                    sh 'docker --version'
                }
            }
        }
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
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t dminus251/calculator:latest .'
                }
            }
        }
	stage('Docker Login') {
            steps {
                script {
                    // Docker Hub에 로그인
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }
	stage("Docker push"){
	  steps{
	    sh "docker push dminus251/calculator:latest"
	  }
	}
	stage("Deploy to staging"){
	  steps{
	    sh "docker run -d --rm -p 8765:8081 --name calcForStaging dminus251/calculator:latest"
	  }
	}
	stage("Acceptance test"){
	  steps{
	    sleep 30 //docker run이 확실히 실행될 때까지 기다림
	    sh "docker logs calcForStaging"
	    sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
	  }  
	}
    }
    //까지 stages
    post{
	always{
	  sh "docker stop calcForStaging"
	}
    }
}
