FROM jenkins/jenkins:lts

USER root

# Install necessary packages for Docker and Ansible
RUN apt-get update -y && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Set up the Docker repository
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Install Docker CE
RUN apt-get update -y && \
    apt-get install -y docker-ce

# Install Ansible
RUN apt-get install -y ansible

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins
