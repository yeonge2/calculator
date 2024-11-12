# dminus251/jenkins-docker-agent:latest
FROM gradle:jdk17

# Docker 클라이언트 설치
RUN apt-get update && \
    apt-get install -y docker.io

# Jenkins가 Docker를 사용할 수 있도록 권한 설정
USER root
