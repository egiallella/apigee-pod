FROM docker.io/redhat/ubi9:latest
USER 0
RUN dnf install rsync less vim jq python3-requests git -y
USER 1001
CMD ["sleep","infinity"]


