FROM golang:1.13.4-alpine3.10
WORKDIR /app
RUN apk update && apk upgrade  -U -a && \
    apk add bash git openssh gcc libc-dev
RUN apk add --update --no-cache gcc g++ make libc6-compat

ARG VIPS_VERSION="8.6.5"

RUN wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz
RUN apk update && apk add automake build-base pkgconfig glib-dev gobject-introspection libxml2-dev expat-dev jpeg-dev libwebp-dev libpng-dev
# Exit 0 added because warnings tend to exit the build at a non-zero status
RUN tar -xf vips-${VIPS_VERSION}.tar.gz && cd vips-${VIPS_VERSION} && ./configure && make && make install && ldconfig; exit 0
RUN apk del automake build-base
