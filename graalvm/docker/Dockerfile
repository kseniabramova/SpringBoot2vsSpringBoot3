FROM gradle:8.4-jdk21 as graalvm-builder
WORKDIR /app

COPY . .

RUN ./gradlew build

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY build/libs/graalvm.jar /app/graalvm.jar

ENTRYPOINT ["java", "-jar", "/app/graalvm.jar"]
