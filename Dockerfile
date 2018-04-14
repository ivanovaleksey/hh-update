FROM ruby:2.5-alpine

RUN apk add --no-cache \
    bash \
    build-base

RUN mkdir /app
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

ENV NO_RBENV=1
RUN whenever --update-crontab

CMD crond -l 2 -f
