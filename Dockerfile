FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get update -qq && \
  apt-get install -y build-essential \
  default-libmysqlclient-dev \
  nodejs \
  mysql-client \
  xvfb \
  redis-tools && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  lsof \
  vim

ENV APP_ROOT /opt/webapp
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock /tmp/
RUN cd /tmp && bundle
RUN gem install foreman

RUN npm install -g yarn
COPY package.json yarn.lock /tmp/
RUN cd /tmp && yarn

ADD . $APP_ROOT
RUN cp -a /tmp/node_modules $APP_ROOT


RUN cd $APP_ROOT && rm -rf public/packs/* || true && bundle exec rake react_on_rails:locale && bin/webpack
