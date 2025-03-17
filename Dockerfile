# Stage 1: Build the application with Gradle
FROM gradle:7.3.3-jdk11 AS builder

# Set working directory for the project
WORKDIR /app

# Copy the Gradle wrapper and project files
COPY gradlew . 
COPY build.gradle . 
COPY src ./src

# Set the correct permissions on the gradlew script
RUN chmod +x ./gradlew

# Build the WAR file using Gradle
RUN ./gradlew clean build --no-daemon

# Stage 2: Set up the runtime image with Tomcat
FROM tomcat:9.0

# Set working directory in Tomcat's webapps folder
WORKDIR /usr/local/tomcat/webapps/

# Copy the built WAR file from the builder stage to Tomcat's webapps folder
COPY --from=builder /app/build/libs/ENSF400-FinalProject-1.0.0.war ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
