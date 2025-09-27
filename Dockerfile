FROM quay.io/wildfly/wildfly:latest

COPY build/libs/web_lab2-1.1.war /opt/jboss/wildfly/standalone/deployments

EXPOSE 8080 9990

# Данные для создания профиля админа
# ВНИМАНИЕ! Введите ДРУГИЕ данные через --build-arg
ARG ADMIN_NAME="admin"
ARG ADMIN_PASSWRORD="admin"

RUN "/opt/jboss/wildfly/bin/add-user.sh" -a $ADMIN_NAME $ADMIN_PASSWORD

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
