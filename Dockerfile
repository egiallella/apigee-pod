FROM docker.io/redhat/ubi9:latest
USER 0
RUN dnf install rsync less vim jq python3-requests git -y
ADD https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest-4.14/openshift-client-linux.tar.gz /usr/bin
RUN cd /usr/bin && tar -xzf openshift-client-linux.tar.gz && rm -f openshift-client-linux.tar.gz
RUN dnf clean all
USER 1001
CMD ["sleep","infinity"]


