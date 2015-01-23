#!/bin/sh

# This will run a new Tomcat container detached

docker run --name=tomcat -h=oseraf-tomcat -e TOMCAT_PASS="password" -p  8081:8080 -d oseraf/tomcat
