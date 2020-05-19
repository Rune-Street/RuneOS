FROM ubuntu:bionic-20200403
MAINTAINER Clement Liaw "https://github.com/iExalt"

WORKDIR /root
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y software-properties-common wget && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository -y ppa:apt-fast/stable && add-apt-repository -y ppa:openjdk-r/ppa && add-apt-repository -y https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update && apt-get install -y apt-fast && \
    apt-fast install -y --no-install-recommends lxde apt-utils xvfb x11vnc adoptopenjdk-14-openj9-jre && \
    apt-fast install -y scrot python3-tk python3.8 python3-setuptools python3-pip && \
    python3.8 -m pip install ptpython==3.0.2 PyAutoGUI==0.9.50 pynput==1.6.8 && \
    sed -i '$ d' /root/.profile && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD Xvfb :1 -screen 0 1920x1080x24 -cc 4 -nolisten tcp &
