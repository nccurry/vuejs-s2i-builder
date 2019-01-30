# VueJS s2i Builder

A docker image for building chained source-to-image VueJS web applications.

## Building this image
```shell
docker build -t vuejs-s2i-builder:latest .
```

## Using this image in a development build

If you want to test building and deploying your application with this image only you can use the following:
```shell
# From github
s2i build -e DEV_MODE=true . nccurry/vuejs-s2i-builder:latest sample-app:latest
docker run -p 8080:8080 -d --name sample-app sample-app:latest

# From a local copy
rm -rf node_modules && \
s2i build -e DEV_MODE=true --copy . nccurry/vuejs-s2i-builder:latest sample-app:latest
docker run -p 8080:8080 -d --name sample-app sample-app:latest
```

## Examples and documentation

* [Source-to-image Documentation](https://github.com/openshift/source-to-image)
* [Inspiration Repository](https://github.com/nodeshift/centos7-s2i-nodejs)
* [RHEL7 s2i Example](https://access.redhat.com/containers/?tab=docker-file#/registry.access.redhat.com/rhscl/s2i-core-rhel7/images/1-47)
