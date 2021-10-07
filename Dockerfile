ARG BASE_IMAGE=centos:7.9.2009
FROM ${BASE_IMAGE}
ENV REFRESHED_AT 2021-10-01
LABEL Name="dockter/fpm" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Avoid "Error: libselinux conflicts with fakesystemd-1-17.el7.centos.noarch"

#RUN yum -y swap fakesystemd systemd \
# && yum -y install systemd-devel \
# && yum clean all

# --- Install system packages -------------------------------------------------

RUN yum -y update

# Install [base, ruby] dependencies.

RUN yum -y install centos-release-scl

RUN yum -y install rh-ruby23
RUN yum -y install rh-ruby23-ruby-devel
RUN yum -y install gcc
RUN yum -y install make
RUN yum -y install rpm-build
RUN yum -y install rubygems


RUN scl enable rh-ruby23 bash

#RUN yum -y install tar
#RUN yum -y install wget
#RUN yum -y install gcc
#RUN yum -y install make
#RUN yum -y install rpm-build
#RUN yum -y install ruby-devel
#RUN yum -y install rubygems
#RUN yum -y install which



RUN gem install ffi --version "1.12.2"

# Install Effing Package Manager (FPM).

RUN gem install --no-ri --no-rdoc fpm

# Runtime execution.

ENTRYPOINT ["fpm"]
