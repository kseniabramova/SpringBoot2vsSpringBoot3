FROM ghcr.io/graalvm/graalvm-ce:latest as build
WORKDIR /app
#RUN java -version

COPY *.gradle gradle.* gradlew /app/
RUN mkdir -p /app/gradle
COPY gradle/wrapper /app/gradle/wrapper
COPY ./src /app/src

# fix Windows format
RUN sed -i 's/\r$//' gradlew
RUN ./gradlew build
#RUN ls -la

RUN mv build/libs/graalvm.jar /app/graalvm.jar

ENTRYPOINT ["java", "-jar", "/app/graalvm.jar"]
