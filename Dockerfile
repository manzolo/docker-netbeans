FROM ubuntu:focal
MAINTAINER Andrea Manzi manzolo@libero.it

ENV NETBEANS_VERSION=12.4
ENV NETBEANS_HOME=/root/NetBeansProjects/
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y gnupg2 openjdk-16-jdk xauth wget zip unzip
# Install prerequisites (xauth, zip, ecc.)

# Download netbeans
RUN wget --progress=dot:giga https://downloads.apache.org/netbeans/netbeans/${NETBEANS_VERSION}/Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh \
	&& chmod +x ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh \
	&& ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh --silent \
	&& rm -f ./Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh 

RUN apt update \
  && apt install lsb-release ca-certificates apt-transport-https software-properties-common -y \
  && add-apt-repository ppa:ondrej/php \
  && apt install -y php8.0 \
  && apt install -y php php-cli php-fpm php-json php-mysql php-pgsql php-sqlite3 php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath php-common php-imap php-redis php-snmp php-xml php-xdebug 

RUN apt install -y curl firefox

RUN apt install -y yarn

COPY php-xdebug.ini /etc/php/8.0/mods-available/xdebug.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer -v

WORKDIR $NETBEANS_HOME

RUN java -version

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
