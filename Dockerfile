FROM maven:3.8.2-jdk-8

WORKDIR /devopsspringapp
COPY . .
RUN mvn clean install -Dmaven.test.skip

CMD mvn devopsspringapp:run
