# kubernetes fluentd
Collects logs from your nodejs application, assumed you use winston like [this](https://github.com/waleedsamy/hello-world-expressjs-docker) project.

[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/waleedsamy/k8s-fluentd-nodejs-winston/)


#### Notes
* Fluentd configuration is based on [gcp-fluentd](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-gcp/fluentd-gcp-image) and [fabric8io/docker-fluentd-kubernetes](https://hub.docker.com/r/fabric8/fluentd-kubernetes)
* Fluentd exclude kubernetes logs which start with `kube` or `k8s`
