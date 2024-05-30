FROM docker.io/redhat/ubi9:latest
USER 0
RUN dnf install dstat parted  pcp-system-tools pcp-doc procps-ng perf psmisc hostname iproute sysstat iotop conntrack-tools procps-ng ethtool numactl psmisc hostname iproute sysstat net-tools procps-ng util-linux rsync less vim tcpdump jq s3cmd fio python3-requests git -y
USER 1001
CMD ["sleep","infinity"]
