FROM docker.io/redhat/ubi9:latest

# Per installare e modificare sono necessari i permessi di ROOT
USER 0

# OS RPMs
RUN dnf install rsync less vim jq python3-requests git -y

# OCP CLI
RUN echo OCP CLI
RUN ls -la /usr/local/bin
ADD https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-4.14/openshift-client-linux.tar.gz /usr/local/bin
RUN cd /usr/local/bin && tar -xzf openshift-client-linux.tar.gz && rm -f openshift-client-linux.tar.gz
RUN ls -la /usr/local/bin

# Helm CLI
RUN echo Helm CLI
RUN ls -la /usr/local/bin
ADD https://get.helm.sh/helm-v3.15.1-linux-amd64.tar.gz /usr/local/bin
RUN cd /usr/local/bin && tar -xzf helm-v3.15.1-linux-amd64.tar.gz && rm -f helm-v3.15.1-linux-amd64.tar.gz && mv /usr/local/bin/linux-amd64/helm /usr/local/bin && rm -rf /usr/local/bin/linux-amd64
RUN ls -la /usr/local/bin/

# Google CLI
RUN echo  Google CLI
COPY files/etc/yum.repos.d/google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo
RUN  dnf install google-cloud-cli -y



RUN dnf clean all

# OCP non permette ad un POD di essere eseguito come ROOT
USER 1001

# Per non far terminare MAI il POD
CMD ["sleep","infinity"]


