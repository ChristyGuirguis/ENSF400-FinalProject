# Gradle 7.6 and JDK 11 image
FROM gradle:7.6.1-jdk11 AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build Gradle
RUN gradle build

# Use the official Tomcat image for deployment
FROM tomcat:9.0

# Set working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the built WAR file from the Gradle build stage
COPY --from=build /app/build/libs/ENSF400-FinalProject-1.0.0.war ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
