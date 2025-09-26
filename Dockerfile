FROM quay.io/wildfly/wildfly:latest

COPY build/libs/web_lab2-1.1.war /opt/jboss/wildfly/standalone/deployments

LABEL maintainer="maxkarn"
LABEL description="web lab 2 docker compose"

EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
