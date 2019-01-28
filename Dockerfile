FROM node:current-alpine

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
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH

COPY ./s2i/ $STI_SCRIPTS_PATH

# Install bash TODO: Remove this dependency and use sh
# Create default user, home directory, and modify permissions.
# Install vue cli
RUN apk add bash && \
    mkdir -p {HOME} && \
    chown -R 1001:0 ${APP_ROOT} && \
    useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default && \
    npm install -g @vue/cli

USER 1001

EXPOSE 8080

WORKDIR ${HOME}

CMD ${STI_SCRIPTS_PATH}/usage
