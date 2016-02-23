FROM mhart/alpine-node:latest


# Configuration

ENV ELIXIR_VERSION 1.2.3


# Erlang

RUN apk --update add \
  erlang \
  erlang-asn1 \
  erlang-crypto \
  erlang-dev \
  erlang-erl-interface \
  erlang-eunit \
  erlang-inets \
  erlang-parsetools \
  erlang-public-key \
  erlang-sasl \
  erlang-ssl \
  erlang-syntax-tools \
  git \
  wget && \
  rm -rf /var/cache/apk/*


# Elixir

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN apk --update add --virtual build-dependencies \
  wget ca-certificates && \
  wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
  mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
  unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
  rm Precompiled.zip && \
  apk del build-dependencies && \
  rm -rf /etc/ssl && \
  rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info


# Phoenix

RUN apk --update add inotify-tools && \
  rm -rf /var/cache/apk/*

RUN yes | mix archive.install \
  https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez


# Init

WORKDIR /app
CMD /bin/sh
