# samples
provide example for fluentd shipper (sfl.conf) and receiver (mfl.conf) configuration.

#### shipping logs to another fluentd
* create a network to access other containers with name
``` bash
 docker network create infra
```

* run main container(s)
 ```bash
 docker run -d \
   -p 24225:24224 \
   -v $(pwd):/fluentd/etc \
   -e FLUENTD_CONF=mfl.conf \
   --name mfl1 \
   --net=infra --net-alias mfl1 \
   fluent/fluentd

 docker run -d \
   -p 24226:24224 \
   -v $(pwd):/fluentd/etc \
   -e FLUENTD_CONF=mfl.conf \
   --name mfl2 \
   --net=infra --net-alias mfl2 \
   fluent/fluentd
 ```

* run shipper container
 ```bash
  docker run -d \
    -p 24224:24224 \
    -v $(pwd):/fluentd/etc \
    -e FLUENTD_CONF=sfl.conf \
    --name sfl \
    --net=infra --net-alias sfl \
    fluent/fluentd
 ```

* run regular container configured to send logs to fluentd
 ```bash
  docker run --net=infra --log-driver=fluentd ubuntu sh -c 'while true; do echo "Hello"; sleep 1; done'
 ```
you should see your log message `Hello` forwarded from fluentd container `sfl` to the other fluentd containers `mfl1` or `mfl2`
