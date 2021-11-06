FROM ubuntu:latest

ENV POWERPANEL_VERSION=470

RUN apt-get update && apt-get install -y \
      curl \
      ca-certificates \
      libgusb2 \
      libusb-1.0-0 \
      usb.ids \
      usbutils \
      expect \
      tzdata \
      --no-install-recommends \
      && rm -rf /var/lib/apt/lists/*
RUN curl -s -L https://dl4jz3rbrsfum.cloudfront.net/software/ppb${POWERPANEL_VERSION}-linux-x86_x64.sh -o ppb-linux-x86_64.sh \
 && chmod +x ppb-linux-x86_64.sh

RUN \
        ln -fs /usr/share/zoneinfo/America/Vancouver /etc/localtime && \
        dpkg-reconfigure -f noninteractive tzdata

COPY --from=copier install.exp install.exp
RUN chmod +x install.exp && expect ./install.exp && rm ppb-linux-x86_64.sh && rm install.exp

EXPOSE 3052
EXPOSE 53568
VOLUME ["/usr/local/ppbe/db_local/"]

HEALTHCHECK CMD curl -vs --fail http://127.0.0.1:3052/ || exit 1
ENTRYPOINT ["/usr/local/PPB/ppbed", "run"]

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="pixielark/powerpanel-business" \
      org.label-schema.description="Docker image for PowerPanel Business" \
      org.label-schema.license="MIT" \
      org.label-schema.url="https://github.com/pixielark/powerpanel-business-docker" \
      org.label-schema.vendor="pixielark" \
      org.label-schema.version=$POWERPANEL_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/pixielark/powerpanel-business-docker.git" \
      org.label-schema.vcs-type="Git" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="pixielark/powerpanel-business" \
      org.opencontainers.image.description="Docker image for PowerPanel Business" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.url="https://github.com/pixielark/powerpanel-business-docker" \
      org.opencontainers.image.authors="pixielark" \
      org.opencontainers.image.vendor="pixielark" \
      org.opencontainers.image.version=$POWERPANEL_VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/pixielark/powerpanel-business-docker.git"
