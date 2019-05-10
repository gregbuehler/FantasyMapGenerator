FROM alpine:latest AS builder

RUN builddeps=' \
              python-dev \
              py3-pip \
              py-cairo-dev \
              git \
              build-base \
              cmake \
              ' \
    && apk --no-cache add \
    python \
    cairo \
    py-cairo \
    $builddeps \
    && pip3 install --upgrade pip \
    && pip3 install \
              pycairo \
    && git clone https://github.com/rlguy/FantasyMapGenerator.git \
    && mkdir -p FantasyMapGenerator/build \
    && cd FantasyMapGenerator/build \
    && git rev-parse --short HEAD \
    && cmake .. \
    && make 
    #&& apk del --purge $builddeps
    
ENTRYPOINT [ "FantasyMapGenerator/build/map_generation" ]