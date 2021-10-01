ARG IMAGE_FPM_BUILDER=alpine:3.12
FROM ${IMAGE_FPM_BUILDER}

ENV REFRESHED_AT 2021-09-30
LABEL Name="docktermj/fpm" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Install FPM.

RUN apk add --no-cache \
      gcc \
      libc-dev \
      libffi-dev \
      make \
      rpm \
      ruby \
      ruby-dev \
      ruby-etc \
 && gem install \
      --no-document \
      --version 1.13.1 \
      fpm

ENTRYPOINT ["fpm"]
