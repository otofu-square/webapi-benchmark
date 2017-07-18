FROM ruby:2.4.1

COPY . /app

WORKDIR /app

RUN gem install bundler --no-document
RUN bundle install
