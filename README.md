docker-tomcat
=============

OSERAF container for Tomcat

Installation
=============

1. Connect to AWS or Server Instance (must have docker enabled and http(s) access
2. Clone or update docker repository on AWS docker instance (e.g. git clone  https://github.com/OSERAF/docker-tomcat.git)
3. verify settings in conf/application.conf, conf/tomcat-users.xml, conf/ikanow-duke.conf and edit for your environment

Editing files in Docker Container
=============

You can connect to a bash prompt of a running docker container from an ssh session as follows:

1. get the docker container id with sudo docker ps -a (assumes your user is in sudoers)
2. connect with bash shell as follows:  sudo docker exec -i -t <container id> bash

