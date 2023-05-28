# Start with a base image containing Java runtime
FROM azul/zulu-openjdk:17 as build

# Set the working directory in the image to /app
WORKDIR /app

# Copy Gradle executable and other Gradle files to the image
COPY gradlew .
COPY gradle gradle

# Copy build file to the image
COPY build.gradle .

# Copy your source code to the image
COPY src src

# Build the application
RUN ./gradlew clean build

# -----

# Start a new stage from the Java runtime
FROM azul/zulu-openjdk:17 as runtime

ARG JAR_FILE_PATH=app/build/libs/*.jar

# Copy the jar file from the build stage
COPY --from=build ${JAR_FILE_PATH} app.jar

# Run the application
ENTRYPOINT ["java","-jar","/app.jar"]
