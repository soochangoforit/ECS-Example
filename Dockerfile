FROM azul/zulu-openjdk:17
CMD ["./gradlew", "clean", "build"]
ARG JAR_FILE_PATH=ecs/build/libs/ecs-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE_PATH} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]