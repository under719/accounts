# Base image
FROM openjdk:21-jdk-slim

# Add a volume pointing to /tmp
WORKDIR /tmp

# Set Env
ENV APP_HOME=/app
WORKDIR $APP_HOME

# Copy JAR File
COPY ./target/*.jar /eureka-client-accounts.jar

# Expose the application port (18080)
EXPOSE 18080

# Run the JAR File
ENTRYPOINT ["java", "-jar", "/eureka-client-accounts.jar"]
