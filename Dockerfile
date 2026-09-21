# ---------- Stage 1: build con Gradle ----------
FROM gradle:jdk17 AS build
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew bootJar -x test --no-daemon

# ---------- Stage 2: ejecución con OpenJDK ----------
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/discografia-1.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
