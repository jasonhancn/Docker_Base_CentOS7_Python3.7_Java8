FROM centos:7
LABEL maintainer="i@noobear.com"
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
# 配置系统时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# YUM配置，安装Supervisor
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y supervisor && \
    yum clean all
# 编译安装Python3.7（/opt/python37/bin/python3）
RUN yum update -y && \
    yum install -y wget gcc make zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel libffi-devel  && \
    wget -c https://www.python.org/ftp/python/3.7.11/Python-3.7.11.tgz && \
    tar -zxf Python-3.7.11.tgz && \
    cd Python-3.7.11 && \
    ./configure prefix=/opt/python37 --enable-optimizations && \
    make -j && make install && \
    cd .. && \
    rm -rf Python-3.7.11 Python-3.7.11.tgz && \
    yum remove -y bzip2-devel libffi-devel ncurses-devel openssl-devel readline-devel sqlite-devel tk-devel zlib-devel expat-devel fontconfig-devel freetype-devel keyutils-libs-devel krb5-devel libX11-devel libXau-devel libXft-devel libXrender-devel libcom_err-devel libpng-devel libselinux-devel libsepol-devel libuuid-devel libverto-devel libxcb-devel pcre-devel tcl-devel xorg-x11-proto-devel && \
    yum clean all
# 安装AdoptOpenJDK 8
RUN echo '[AdoptOpenJDK]' > /etc/yum.repos.d/AdoptOpenJDK.repo && \
    echo 'name=AdoptOpenJDK' >> /etc/yum.repos.d/AdoptOpenJDK.repo && \
    echo 'baseurl=http://adoptopenjdk.jfrog.io/adoptopenjdk/rpm/centos/$releasever/$basearch' >> /etc/yum.repos.d/AdoptOpenJDK.repo && \
    echo 'enabled=1' >> /etc/yum.repos.d/AdoptOpenJDK.repo && \
    echo 'gpgcheck=1' >> /etc/yum.repos.d/AdoptOpenJDK.repo && \
    echo 'gpgkey=https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public' >> /etc/yum.repos.d/AdoptOpenJDK.repo && \
    yum update -y && \
    yum install -y adoptopenjdk-8-hotspot && \
    yum clean all
