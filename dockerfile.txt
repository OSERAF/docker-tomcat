FROM centos:centos7
MAINTAINER Gregg Hanold "ghanold79@gmail.com"

RUN yum update -y && \
    yum install -y wget pwgen ca-certificates && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.11
ENV CATALINA_HOME /tomcat

# Download JDK
RUN cd /opt;wget https://s3.amazonaws.com//jdk-7u67-linux-x64.tar.gz
#gunzip JDK
RUN cd /opt;gunzip jdk-7u67-linux-x64.tar.gz
RUN cd /opt;tar xvf jdk-7u67-linux-x64.tar
RUN alternatives –install /usr/bin/java java /opt/jdk1.7.0_67/bin/java 2

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 8080
CMD ["/run.sh"]