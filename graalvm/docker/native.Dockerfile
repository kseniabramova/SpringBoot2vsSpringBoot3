FROM ghcr.io/graalvm/graalvm-ce:latest as build
WORKDIR /app
#RUN java -version

COPY *.gradle gradle.* gradlew /app/
RUN mkdir -p /app/gradle
COPY gradle/wrapper /app/gradle/wrapper
COPY ./src /app/src
# fix if Windows format
RUN sed -i 's/\r$//' gradlew

RUN gu install native-image


RUN ./gradlew nativeCompile


RUN chmod +x /app/build/native/nativeCompile
RUN ls -la /app/build/native/nativeCompile

ENTRYPOINT ["/app/build/native/nativeCompile/graalvm"]


