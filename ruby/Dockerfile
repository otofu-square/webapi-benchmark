FROM ruby:2.4.1

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler --no-document
RUN bundle install
