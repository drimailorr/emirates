FROM openjdk:11.0.1-jre-slim-sid
COPY all.jar /all.jar
CMD ["java", "-jar", "/all.jar"]
