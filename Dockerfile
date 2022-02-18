FROM ubuntu:focal
MAINTAINER Andrea Manzi manzolo@libero.it

ENV NETBEANS_VERSION=12.6
ENV NETBEANS_HOME=/root/NetBeansProjects/
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y gnupg2 openjdk-16-jdk xauth wget zip unzip
# Install prerequisites (xauth, zip, ecc.)

# Download netbeans
RUN wget --progress=dot:giga https://downloads.apache.org/netbeans/netbeans-installers/${NETBEANS_VERSION}/Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh \
	&& chmod +x ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh \
	&& ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh --silent \
	&& rm -f ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh 

# Aditional Drivers
WORKDIR $NETBEANS_HOME

RUN java -version

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
