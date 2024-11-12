# Dockerfile for Java application
FROM openjdk:17-slim

# JAR 파일을 이미지에 복사
COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl
# 컨테이너가 시작될 때 JAR 파일을 실행하도록 설정
ENTRYPOINT ["java", "-jar", "app.jar"]

