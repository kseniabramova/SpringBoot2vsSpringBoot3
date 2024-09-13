# Этап 1: Сборка JAR файла с использованием Gradle и JDK 21
FROM gradle:8.4-jdk21 as build-gradle
WORKDIR /app
COPY . .
RUN ./gradlew build

# Этап 2: Сборка нативного бинарника с использованием GraalVM
FROM ghcr.io/graalvm/native-image-community:21-ol8 as build-native
WORKDIR /app

# Копируем JAR-файл из сборочного контейнера
COPY --from=build-gradle /app/build/libs/graalvm.jar /app/graalvm.jar

# Сборка нативного бинарника
RUN native-image -jar graalvm.jar -H:Name=graalvm --no-fallback -H:+StaticExecutableWithDynamicLibC

# Этап 3: Финальный образ
FROM gcr.io/distroless/base
WORKDIR /app

# Копируем скомпилированное нативное приложение из контейнера build-native
COPY --from=build-native /app/graalvm /app/graalvm

EXPOSE 8080
CMD ["./graalvm"]
