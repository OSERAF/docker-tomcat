FROM centos:centos7
MAINTAINER Gregg Hanold "ghanold79@gmail.com"

RUN yum update -y && \
    yum install -y wget tar pwgen ca-certificates && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.11
ENV CATALINA_HOME /tomcat

# Download JDK
RUN yum -y install java-1.7.0-openjdk-devel


# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.17/bin/apache-tomcat-8.0.17.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.17/bin/apache-tomcat-8.0.17.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD scripts/run.sh /run.sh
RUN chmod +x /*.sh
ADD bullseye/bullseye.war /tomcat/webapps/bullseye.war
ADD conf/dukeConf-ikanow.xml /dukeConf-ikanow.xml
ADD conf/ikanow-conf.xml /dukeConf-ikanow.xml
#ADD conf/application.conf /application.conf
#ADD conf/web.xml /web.xml
ADD conf/tomcat-users.xml /tomcat/conf/tomcat-users.xml
ADD scripts/setenv.sh /tomcat/bin/setenv.sh
RUN chmod +x /tomcat/bin/setnev.sh

EXPOSE 8080

CMD ["/run.sh"]
