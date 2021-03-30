FROM ruby:2.6.2-stretch

RUN apt-get update -qq && \
apt-get install -y build-essential nodejs postgresql-client

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler && \
bundle install

COPY . /app

COPY ./web_entry.sh /app/
RUN chmod a+x /app/web_entry.sh

ENTRYPOINT ["bundle", "exec"]

CMD . /app/web_entry.sh