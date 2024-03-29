# FROM maven:3.8-openjdk-11 AS build
# COPY . .
# RUN mvn clean package -DskipTests

# FROM openjdk:11-jdk-slim-buster
# COPY --from=build /target/stripe-service-0.0.1-SNAPSHOT.jar shopee-service.jar
# EXPOSE 8000
# ENTRYPOINT ["java","-jar","shopee-service.jar"]

# ``````````````````````````````````````
# FROM maven:3.8-openjdk-11 AS build
# COPY . .
# RUN mvn clean install

# FROM openjdk:11-jre-slim

# WORKDIR /app

# COPY --from=build /target/stripe-service-0.0.1-SNAPSHOT.jar /app/shopee-service.jar

# EXPOSE 8080

# CMD ["java", "-jar", "shopee-service.jar"]

# ``````````````````````````````````````````
# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package

# Use a lightweight base image for runtime
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar shopee-service.jar
EXPOSE 8080
CMD ["java", "-jar", "shopee-service.jar"]



