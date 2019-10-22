FROM openjdk:11.0.1-jre-slim-sid
COPY target/*.jar /all.jar
CMD ["java", "-jar", "/all.jar"]
