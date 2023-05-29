# Start with a base image containing Java runtime
# FROM azul/zulu-openjdk:17 as build

# Set the working directory in the image to /app
# WORKDIR /app

# Copy Gradle executable and other Gradle files to the image
# COPY gradlew .
# COPY gradle gradle

# Copy build file to the image
# COPY build.gradle .

# Copy your source code to the image
# COPY src src

# Build the application
# RUN ./gradlew clean build

# -----

# Start a new stage from the Java runtime
# FROM azul/zulu-openjdk:17 as runtime

# ARG JAR_FILE_PATH=app/build/libs/*.jar

# Copy the jar file from the build stage
# COPY --from=build ${JAR_FILE_PATH} /app/

# Run the application
# ENTRYPOINT ["java","-jar","/app/ecs-0.0.1-SNAPSHOT.jar"]




# FROM azul/zulu-openjdk:17 as build
FROM azul/zulu-openjdk:17 as builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +X ./gradlew
RUN ./gradlew bootJar

FROM azul/zulu-openjdk:17 as runtime
COPY --from=builder build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]