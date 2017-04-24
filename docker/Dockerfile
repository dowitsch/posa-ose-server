FROM elixir:1.3

ENV PHOENIX_VERSION 1.2.0

USER root

RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /usr/src/app
ENV MIX_ENV prod
ENV HOME /usr/src/app

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez
COPY mix.* /usr/src/app/
RUN mix deps.get --only prod
RUN mix deps.compile --only prod
COPY . /usr/src/app/
RUN MIX_ENV=prod mix compile
RUN mix compile.protocols

CMD MIX_ENV=prod mix ecto.migrate && elixir -pa _build/prod/consolidated -S MIX_ENV=prod mix phoenix.server
