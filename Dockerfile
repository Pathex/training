FROM bitwalker/alpine-elixir-phoenix:latest

MAINTAINER XOfSpades

EXPOSE 4000

RUN mkdir /training

WORKDIR /training

ARG mix_env
RUN echo Using mix env $mix_env

RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY package.json /training/package.json
COPY brunch-config.js /training/brunch-config.js


RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /training/_build
RUN mkdir -p /training/config
RUN mkdir /training/lib

COPY mix.exs /training/mix.exs
COPY mix.lock /training/mix.lock

RUN MIX_ENV=$mix_env mix do deps.get, deps.compile

RUN npm install

COPY config/config.exs /training/config/config.exs
COPY config/test.exs /training/config/test.exs
COPY config/dev.exs /training/config/dev.exs
COPY config/prod.exs /training/config/prod.exs

# when using a database
# COPY priv /training/priv

COPY lib /training/lib
COPY web /training/web

RUN MIX_ENV=$mix_env mix compile
