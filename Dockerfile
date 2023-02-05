FROM maven:3.8-jdk-8-slim AS MAVEN_BUILD
WORKDIR /tmp/
COPY pom.xml .
COPY src ./src/
RUN mvn package -DskipTests
 
FROM tomcat:9.0-jre8-alpine
COPY --from=MAVEN_BUILD /tmp/target/eschool.jar eschool.jar

ENTRYPOINT ["java", "-jar", "eschool.jar"]