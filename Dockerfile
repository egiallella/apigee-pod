FROM docker.io/redhat/ubi9:latest
USER 0

# OS RPMs
RUN dnf install rsync less vim jq python3-requests git -y

# OCP CLI
ADD https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-4.14/openshift-client-linux.tar.gz /usr/local/bin
RUN cd /usr/local/bin && tar -xzf openshift-client-linux.tar.gz && rm -f openshift-client-linux.tar.gz

# Google CLI
RUN tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
RUN dnf install google-cloud-cli -y

RUN dnf clean all
USER 1001
CMD ["sleep","infinity"]


