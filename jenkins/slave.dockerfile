FROM ubuntu:latest

USER root

# Install OpenSSH server and OpenJDK 8
RUN apt-get update -y && \
    apt-get install -y openjdk-8-jdk openssh-server

# Create a new user for Jenkins
RUN useradd -m -s /bin/bash jenkins

# Copy the public SSH key for the Jenkins user
COPY jenkins.pub /home/jenkins/.ssh/authorized_keys

# Set permissions for the .ssh directory and authorized_keys file
RUN chown -R jenkins:jenkins /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh && \
    chmod 644 /home/jenkins/.ssh/authorized_keys

# Switch to the Jenkins user
USER jenkins

# Create the Jenkins home directory
RUN mkdir /home/jenkins/jenkins_home

# Set the working directory
WORKDIR /home/jenkins/jenkins_home

# Switch back to root for entrypoint configuration
USER root

# Start the SSH service and keep the container running
ENTRYPOINT service ssh restart && bash
