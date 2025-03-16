# Stage 1: Build the application
FROM gradle:7.3.3-jdk11 AS builder
WORKDIR /desktop_app

# Copy both the gradlew and other project files
COPY gradlew . 
COPY . .

# Set the correct permissions on the gradlew script
RUN chmod +x gradlew

# Build the application
RUN ./gradlew clean build --no-daemon

# Stage 2: Set up the runtime image
FROM openjdk:11-jre-slim

# Copy the built JAR file from the builder stage
COPY --from=builder /desktop_app/build/libs/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
