FROM python:3.7.2-stretch

ARG CLI_VERSION=3.3.1
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Jason Poon" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="Oracle Cloud Infrastructure CLI" \
      org.label-schema.version=$CLI_VERSION \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/jpoon/oci-cli-docker.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.docker.cmd="docker run -v \${HOME}/.oci:/root/.oci -it jpoon/oci-cli:$CLI_VERSION"

WORKDIR /oci-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip

RUN set -ex \
    && wget -qO- -O oci-cli.zip "https://github.com/oracle/oci-cli/releases/download/v${CLI_VERSION}/oci-cli-${CLI_VERSION}.zip" \
    && unzip oci-cli.zip -d .. \
    && rm oci-cli.zip \
    && pip install oci_cli-*-py2.py3-none-any.whl

RUN yes | oci setup autocomplete
