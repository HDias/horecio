FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y
RUN apt-get update -qq
RUN apt-get install -y \
    build-essential \
    git \
    curl \
    sqlite3 \
    vim

WORKDIR /api

COPY Gemfile /api/Gemfile
COPY Gemfile.lock /api/Gemfile.lock

RUN gem install bundler:$(tail -n 1 Gemfile.lock | awk '{print $1}')

RUN bundle install

EXPOSE 3000

