FROM quay.io/wildfly/wildfly:latest

COPY build/libs/web_lab2-1.1.war /opt/jboss/wildfly/standalone/deployments

EXPOSE 8080 9990

RUN "/opt/jboss/wildfly/bin/add-user.sh" -u ${ADMIN_NAME} -p ${ADMIN_PASSWORD}

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
