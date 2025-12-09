FROM openjdk:17-alpine
WORKDIR /app
COPY target/devcalc-api-1.0.0.jar app.jar
EXPOSE 7070
CMD ["java", "-jar", "app.jar"]
