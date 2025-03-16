#linux-based jdk 11 image
FROM openjdk:11-jdk-slim

WORKDIR /app

COPY . .

RUN chmod +x gradlew

ENV PORT=8080

EXPOSE 8080

# Run app and keep it running
CMD ["./gradlew", "appRun"]
