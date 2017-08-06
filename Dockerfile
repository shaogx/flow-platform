# flow.ci base docker includes jre 8 , tomcat and flow.ci api and cc war
# VERSION beta 0.1

# The image provides default settings for flow.ci
# if you want to customize flow.ci settings file,
# please mount to /etc/flow.ci to customize  app-api.properties,
# and app-cc.properties in config folder

FROM tomcat:8.5.16-jre8

# setup flow.ci default environments
ENV FLOW_PLATFORM_DIR=/etc/flow.ci
ENV FLOW_PLATFORM_CONFIG_DIR=/etc/flow.ci/config

RUN mkdir -p $FLOW_PLATFORM_DIR
RUN mkdir -p $FLOW_PLATFORM_CONFIG_DIR

# setup flow.ci default configuration
COPY ./docker/app-cc.properties $FLOW_PLATFORM_CONFIG_DIR
COPY ./docker/app-api.properties $FLOW_PLATFORM_CONFIG_DIR

# config tomcat
COPY ./docker/tomcat-users.xml $CATALINA_HOME/conf

# set wars to tomcat
COPY ./platform-control-center/target/flow-control-center.war $CATALINA_HOME/webapps
COPY ./platform-api/target/flow-api.war $CATALINA_HOME/webapps

WORKDIR $FLOW_PLATFORM_DIR