FROM node:18

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN apt-get update && \
    apt-get install -y npm
