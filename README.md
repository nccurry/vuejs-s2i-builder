https://docs.okd.io/latest/creating_images/s2i.html

https://github.com/nodeshift/centos7-s2i-nodejs

https://github.com/nodeshift/centos7-s2i-web-app

https://access.redhat.com/containers/?tab=docker-file#/registry.access.redhat.com/rhscl/s2i-core-rhel7/images/1-47

# Building from local folder
```shell
rm -rf node_modules && \
s2i build -e DEV_MODE=true --copy . vuejs-s2i-builder:latest digital-tabletop-test
```
