# --- Build-Image ---
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .

# WICHTIG: Production-Build für Vaadin
RUN mvn clean package -Pproduction -DskipTests

# --- Run-Image ---
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]


