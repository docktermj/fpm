FROM centos:7.7.1908

ENV REFRESHED_AT 2021-10-01

# --- Install system packages -------------------------------------------------

RUN yum -y update

# Install [base, ruby] dependencies.

RUN yum -y install \
    git \
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
