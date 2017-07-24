FROM elixir:latest

RUN mkdir /app
WORKDIR /app
COPY . .

RUN apt-get update && \
    apt-get install -y --no-install-recommends

COPY mix.* /app/
COPY config /app/config

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile
