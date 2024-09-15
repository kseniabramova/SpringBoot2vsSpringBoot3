FROM ghcr.io/graalvm/graalvm-ce:latest as build
WORKDIR /app
#RUN java -version

COPY *.gradle gradle.* gradlew /app/
RUN mkdir -p /app/gradle
COPY gradle/wrapper /app/gradle/wrapper
COPY ./src /app/src

RUN gu install native-image
# fix if Windows format
RUN sed -i 's/\r$//' gradlew

RUN ./gradlew nativeCompile
RUN ls -la

EXPOSE 8081
CMD ["./build/libs/graalvm"]

