#===========
# Build Stage
#===========
FROM elixir:1.10.0-alpine as build

ARG APP
ARG BUILD_ENV

# install build dependencies
RUN apk add --update git build-base

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=BUILD_ENV

EXPOSE 8080

COPY . /build

WORKDIR /build/app/$APP

# Install dependencies and build Release
RUN mix deps.get && \
    mix release

RUN mix deps.get --only prod
RUN mix compile
RUN echo y | mix release.clean --implode
RUN mix release

WORKDIR /build

CMD ["/bin/sh"]