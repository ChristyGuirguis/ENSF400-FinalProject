# Gradle 7.6 and JDK 11 image
FROM gradle:7.6.1-jdk11 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build Gradle (using the wrapper)
RUN chmod +x gradlew && ./gradlew build

# Verify that the WAR file was generated
RUN ls -la /app/build/libs/

# Use the official Tomcat image for deployment
FROM tomcat:9.0

# Set working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the built WAR file from the Gradle build stage
COPY --from=build /app/build/libs/*.war ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
