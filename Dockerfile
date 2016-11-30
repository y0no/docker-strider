FROM mhart/alpine-node
MAINTAINER Yoann Ono <yoann.onoditbiot@gmail.com>

ENV STRIDER_TAG v1.9.3
ENV STRIDER_REPO https://github.com/Strider-CD/strider

RUN apk add --no-cache git openssh

RUN git clone --branch $STRIDER_TAG --depth 1 $STRIDER_REPO /app

WORKDIR /app
RUN npm install && npm run build

# Needed to fix strider-docker-runner issue, 
# see: https://github.com/Strider-CD/strider-docker-runner/issues/42
RUN cd /app/node_modules && git clone https://github.com/Strider-CD/strider-docker-runner && cd strider-docker-runner && npm install

EXPOSE 3000

ENTRYPOINT ["npm", "start"]
