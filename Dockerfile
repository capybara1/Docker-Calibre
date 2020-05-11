FROM frolvlad/alpine-glibc:alpine-3.11
ARG VERSION
ARG VCS_REF
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.version="$VERSION" \
      org.label-schema.maintainer="https://github.com/capybara1/" \
      org.label-schema.url="https://github.com/capybara1/Docker-Calibre" \
      org.label-schema.name="calibre" \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-url="https://github.com/capybara1/Docker-Calibre" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.dockerfile="/Dockerfile"
COPY welcome.html /tmp
COPY docker-entrypoint.sh /
VOLUME /data
RUN apk --no-cache --update add bash expect ca-certificates wget python gcc xz xdg-utils mesa-gl qt5-qtbase-x11 nss \
 && wget -nv -O install.sh https://download.calibre-ebook.com/linux-installer.sh \
 && chmod +x install.sh \
 && /install.sh isolated=True \
 && rm install.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
