FROM eclipse-temurin:17-jdk as build
WORKDIR /app
RUN java -version


COPY *.gradle gradle.* gradlew /app/
RUN mkdir -p /app/gradle
COPY gradle/wrapper /app/gradle/wrapper
COPY ./src /app/src


# Исправляем окончания строк, если они в формате Windows
RUN sed -i 's/\r$//' gradlew
RUN ./gradlew build
#RUN ls -la

RUN mv build/libs/graalvm.jar /app/graalvm.jar

# Указываем образ для запуска
FROM openjdk:21-jdk-slim

WORKDIR /app

# Копируем JAR-файл из сборочного контейнера
COPY --from=build /app/graalvm.jar /app/graalvm.jar

# Указываем команду для запуска приложения
ENTRYPOINT ["java", "-jar", "/app/graalvm.jar"]
