# FROM docker.io/redhat/ubi9:latest
FROM image-registry.openshift-image-registry.svc:5000/apigee/httpd-example
# Per installare e modificare sono necessari i permessi di ROOT
USER 0
RUN touch /var/log/httpd/modsec_debug.log
RUN chmod 0600 /var/log/httpd/modsec_debug.log
# RUN touch /etc/apache2/logs/error_log
# RUN touch /etc/apache2/logs/modsec_audit.log
# RUN chmod 0644 /etc/apache2/logs/error_log
# RUN chmod 0600 /etc/apache2/logs/modsec_audit.log
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

# RUN mkdir -p /opt/apigee-hybrid/helm-charts
# WORKDIR /opt/apigee-hybrid/helm-charts
# ARG APIGEE_HELM_CHARTS_HOME=/opt/apigee-hybrid/helm-charts
# ARG CHART_REPO=oci://us-docker.pkg.dev/apigee-release/apigee-hybrid-helm-charts
# ARG CHART_VERSION=1.12.0-hotfix.1
# RUN helm pull $CHART_REPO/apigee-operator --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-datastore --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-env --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-ingress-manager --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-org --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-redis --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-telemetry --version $CHART_VERSION --untar
# RUN helm pull $CHART_REPO/apigee-virtualhost --version $CHART_VERSION --untar

RUN dnf clean all

# OCP non permette ad un POD di essere eseguito come ROOT
USER 1001

# Per non far terminare MAI il POD
CMD ["sleep","infinity"]


