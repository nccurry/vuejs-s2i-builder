FROM alpine:latest

EXPOSE 8080

ENV SUMMARY="" \
    DESCRIPTION=""

LABEL io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="VueJS s2i Builder" \
      io.openshift.tags="builder,nodejs,vuejs,alpine" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.s2i.scripts-url=image:///usr/libexec/s2i \
      com.redhat.deployments-dir="/opt/app-root/src" \
      com.redhat.dev-mode="DEV_MODE:false" \
      com.redhat.dev-mode.port="DEBUG_PORT:5858" \
      maintainer="" \
      summary="$SUMMARY" \
      description="$DESCRIPTION" \
      version="" \
      name="nccurry/vuejs-s2i-builder" \
      usage="s2i build . nccurry/vuejs-s2i-builer myapp"

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    HOME=/opt/app-root/src
ENV PATH=$HOME/bin:$APP_ROOT/bin:$PATH

COPY ./s2i/ $STI_SCRIPTS_PATH
#COPY ./bin/* /usr/bin/

#RUN apk add bash git python2 make g++ npm && \
RUN apk add bash git npm && \
    mkdir -p ${HOME} && \
    adduser -S -u 1001 -G root -h ${HOME} -s /sbin/nologin -g "Default Application User" default && \
    chown -R 1001:0 ${APP_ROOT}

USER 1001

WORKDIR ${HOME}

CMD ${STI_SCRIPTS_PATH}/usage
