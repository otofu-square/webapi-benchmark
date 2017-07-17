FROM elixir:latest

RUN mkdir /app
WORKDIR /app
COPY . .

RUN apt-get update && \
    apt-get install -y --no-install-recommends

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.* /app/
COPY config /app/config
RUN mix do deps.get, deps.compile
