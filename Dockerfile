FROM ubuntu:bionic-20200403
MAINTAINER Clement Liaw "https://github.com/iExalt"

WORKDIR /root
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y software-properties-common wget && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository -y ppa:apt-fast/stable && add-apt-repository -y ppa:openjdk-r/ppa && add-apt-repository -y https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update && apt-get install -y apt-fast && \
    apt-fast install -y --no-install-recommends lxde apt-utils openssh-server adoptopenjdk-13-openj9 && apt-fast install -y tigervnc-standalone-server tigervnc-xorg-extension scrot python3-tk python3-dev python3-pip python3-setuptools && \
    mkdir ~/.vnc && echo "${VNC_PASSWORD-123456}" | vncpasswd -f >> ~/.vnc/passwd && chmod 600 ~/.vnc/passwd && \
    sed -i '$ d' /root/.profile && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DISPLAY=:1
CMD /usr/bin/vncserver -fg -geometry 1920x1080 -localhost no :1
