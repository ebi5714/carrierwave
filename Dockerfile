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

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN cd $APP_ROOT && bundle install

EXPOSE  3000
CMD ["rails", "server", "-b", "0.0.0.0"]

