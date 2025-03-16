# Use the official Tomcat image
FROM tomcat:9.0

# Set working directory
WORKDIR /usr/local/tomcat/webapps/

# Copy the WAR file to the Tomcat webapps directory
COPY build/libs/ENSF400-FinalProject-1.0.0.war ROOT.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
