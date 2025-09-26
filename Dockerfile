FROM jboss/wildfly

COPY build/libs/web_lab2-1.1.war /opt/jboss/wildfly/standalone/deployments

EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh"]