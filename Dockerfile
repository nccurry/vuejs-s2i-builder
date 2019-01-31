FROM alpine:latest

MAINTAINER Nick Curry <code@nickcurry.io>

EXPOSE 8080

ENV SUMMARY="Image for building chained source-to-image VueJS web applications" \
    DESCRIPTION="Image for building chained source-to-image VueJS web applications"

LABEL io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="VueJS s2i Builder" \
      io.openshift.tags="s2i,builder,nodejs,vuejs,alpine" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.s2i.scripts-url=image:///usr/libexec/s2i \
      com.redhat.deployments-dir="/opt/app-root/src" \
      com.redhat.dev-mode="DEV_MODE:false" \
      com.redhat.dev-mode.port="DEBUG_PORT:5858" \
      maintainer="Nick Curry <code@nickcurry.io>" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      version="0.1.0" \
      name="nccurry/vuejs-s2i-builder" \
      help="For more information visit https://github.com/nccurry/vuejs-s2i-builder" \
      usage="s2i build -e DEV_MODE=true --copy . nccurry/vuejs-s2i-builder:latest sample-app"

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    HOME=/opt/app-root/src

ENV PATH=$HOME/node_modules/.bin:$HOME/bin:$APP_ROOT/bin:$PATH

COPY ./s2i/ $STI_SCRIPTS_PATH

RUN apk add --no-cache bash git npm && \
    mkdir -p ${HOME} && \
    adduser -S -u 1001 -G root -h ${HOME} -s /sbin/nologin -g "Default Application User" default && \
    chown -R 1001:0 ${APP_ROOT}

USER 1001

WORKDIR ${HOME}

CMD ${STI_SCRIPTS_PATH}/usage
