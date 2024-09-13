FROM gradle:8.4-jdk21 as build

WORKDIR /app

# Копируем файлы Gradle и исходники
COPY . .

# Выполняем сборку приложения
RUN ./gradlew build

# Упрощаем имя JAR-файла для дальнейшего использования
RUN mv build/libs/graalvm.jar /app/graalvm.jar

# Указываем образ для запуска
FROM openjdk:21-jdk-slim

WORKDIR /app

# Копируем JAR-файл из сборочного контейнера
COPY --from=build /app/graalvm.jar /app/graalvm.jar

# Указываем команду для запуска приложения
ENTRYPOINT ["java", "-jar", "/app/graalvm.jar"]
