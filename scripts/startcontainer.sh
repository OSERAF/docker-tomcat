#!/bin/sh

# This will run a new Tomcat container detached

docker run --name=tomcat -h=oseraf-tomcat -e TOMCAT_PASS="password" -p  8089:8180 -d oseraf/tomcat
