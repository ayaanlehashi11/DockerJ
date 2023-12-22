ARG BUILD_HOME=/DockerJ

#
# Gradle image for the build stage.
#
FROM gradle:jdk11 as build-image

#
# Set the working directory.
#
ARG BUILD_HOME
ENV APP_HOME=$BUILD_HOME
WORKDIR $APP_HOME

#
# Copy the Gradle config, source code, and static analysis config
# into the build container.
#
COPY --chown=gradle:gradle build.gradle settings.gradle $APP_HOME/
COPY --chown=gradle:gradle src $APP_HOME/src
#
# Build the application.
#
RUN gradle --no-daemon build

#
# Java image for the application to run in.
#
FROM openjdk:12-alpine
#
# The command to run when the container starts.
#
ENTRYPOINT java -jar main.jar
