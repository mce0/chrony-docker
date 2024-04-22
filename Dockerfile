FROM alpine:latest

ARG BUILD_DATE

LABEL build_info="mce0/chrony-docker build-date:- ${BUILD_DATE}"
LABEL maintainer="mce0 <contact@mce0.dev>"
LABEL documentation="https://github.com/mce0/chrony-docker"

RUN apk -U upgrade \
 && apk --no-cache add chrony tzdata curl

COPY startup.sh /opt/startup.sh

EXPOSE 123/udp

HEALTHCHECK CMD chronyc -n tracking || exit 1

ENTRYPOINT [ "/bin/sh", "/opt/startup.sh" ]
