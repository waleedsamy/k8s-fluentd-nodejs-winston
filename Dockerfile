FROM fluent/fluentd
MAINTAINER Waleed Samy <waleedsamy634@gmail.com>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH


USER root
RUN apk --no-cache --update add sudo build-base ruby-dev && \

    sudo -u fluent gem install fluent-plugin-elasticsearch fluent-plugin-record-reformer fluent-plugin-secure-forward fluent-plugin-grok-parser fluent-plugin-prometheus fluent-plugin-grep && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

# listen port 24224 for Fluentd forward protocol
EXPOSE 24284
# prometheus plugin expose metrics at 0.0.0.0:24231/metrics
EXPOSE 24231

USER fluent

COPY fluent.conf /fluentd/etc/

# to have the permission to access /var/lib/docker/containers and /var/log/containers
USER root

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
