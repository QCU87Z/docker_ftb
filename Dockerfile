FROM openjdk:11.0-oraclelinux7

COPY server_files /minecraft

RUN yum install -y wget
RUN chmod u+x /minecraft/startserver.sh

WORKDIR /minecraft
# CMD ["/minecraft/startserver.sh"]
CMD ["/bin/bash"]