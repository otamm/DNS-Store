FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /dns_store
WORKDIR /dns_store
COPY Gemfile /dns_store/Gemfile
COPY Gemfile.lock /dns_store/Gemfile.lock
RUN bundle install
COPY . /dns_store

# script executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# start rails server accessible in the local network
CMD ["rails", "server", "-b", "0.0.0.0"]

# created app with docker-compose run web rails new . --force --no-deps --api --database=postgresql -T