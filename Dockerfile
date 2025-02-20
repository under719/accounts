# Base image
FROM openjdk:17-jdk-slim

# Add a volume pointing to /tmp
WORKDIR /tmp

# Set Env
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Copy JAR File
COPY ./build/libs/*.jar /app.jar

# Expose the application port (18080)
EXPOSE 18080

# Run the JAR File
ENTRYPOINT ["java", "-jar", "/app.jar"]
