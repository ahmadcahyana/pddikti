FROM debian:9.11
LABEL "com.xyberian.vendor"="Xyberian ID"
LABEL contact="ahmadcahyana@outlook.com"
LABEL version="1.0"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8 

# Install Dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
        zip \
        manpages \
        unzip \ 
        lsb-release \
        netbase \
        procps \
        libcurl3 \
        ucf \
        libedit2 \
        libx11-6\
        libpng16-16 \
        php-common \
        locales \
        libmagic1 \
        libfreetype6 \
        libfontconfig1 \
        libgd3 \
        libxml2 

RUN locale-gen && localedef -i en_US -f UTF-8 en_US.UTF-8

# COPY INSTALLER
WORKDIR /usr/src/app
COPY ./installer ./installer
RUN chmod -R 777 /usr/src/app/installer

# FRESH INSTALL FEEDER
WORKDIR /usr/src/app/installer/fresh_install
RUN chmod +x INSTALL && ./INSTALL

# INSTALL FEEDER 3.2
WORKDIR /usr/src/app/installer/3.2
RUN chmod +x UPDATE_PATCH.3.2 && ./UPDATE_PATCH.3.2

# INSTALL PATCH 3.3
WORKDIR /usr/src/app/installer/3.3
RUN chmod +x UPDATE_PATCH.3.3 && ./UPDATE_PATCH.3.3

# INSTALL PATCH 3.4
WORKDIR /usr/src/app/installer/3.4
RUN chmod +x UPDATE_PATCH.3.4 && ./UPDATE_PATCH.3.4

# INSTALL PATCH 4.0
WORKDIR /usr/src/app/installer/4.0
RUN chmod +x UPDATE_PATCH.4.0 && ./UPDATE_PATCH.4.0

# INSTALL PATCH 4.1
WORKDIR /usr/src/app/installer/4.1
RUN chmod +x UPDATE_PATCH.4.1 && ./UPDATE_PATCH.4.1

# Additional Files
WORKDIR /usr/src/app/installer/additional
RUN cp ws/sandbox2.php /var/www/html/ws/

EXPOSE 8082
CMD service apache2 start && /etc/init.d/postgresql start && tail -f /var/log/lastlog
