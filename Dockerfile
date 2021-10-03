ARG BASE_IMAGE=centos:7.7.1908
FROM ${BASE_IMAGE}
ENV REFRESHED_AT 2021-10-01
LABEL Name="dockter/fpm" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# --- Install system packages -------------------------------------------------

# Install [base, ruby] dependencies.

RUN yum -y install \
    tar \
    wget \
 && yum -y install \
    gcc \
    make \
    rpm-build \
    ruby-devel \
    rubygems \
    which

# Install Effing Package Manager (FPM).

RUN gem install --no-ri --no-rdoc fpm

# Runtime execution.

ENTRYPOINT ["fpm"]
