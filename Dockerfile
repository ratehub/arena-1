FROM node:8-alpine


ARG VCS_REF
ARG VERSION
ARG BUILD_DATE



LABEL org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.vcs-url="https://github.com/ratehub/arena-rh"\
      org.label-schema.build-date="$BUILD_DATE"\
      org.label-schema.version="$VERSION"\
      org.label-schema.description="Arena for Bee Queue"


# - Upgrade alpine packages to avoid possible os vulnerabilities
# - Tini for Handling Kernel Signals https://github.com/krallin/tini
#   https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#handling-kernel-signals
RUN apk --no-cache upgrade && apk add --no-cache tini

WORKDIR /opt/arena

COPY package.json package-lock.json /opt/arena/
RUN npm ci --production && npm cache clean --force

COPY . /opt/arena/

EXPOSE 4567

USER node

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["npm", "start"]
