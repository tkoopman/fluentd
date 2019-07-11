FROM fluent/fluentd:edge
LABEL maintainer "T Koopman"

# Use root account to use apk
USER root

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-rewrite-tag-filter \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

COPY fluent.conf /fluentd/etc/

USER fluent
