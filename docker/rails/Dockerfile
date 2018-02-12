FROM ruby:2.5.0
ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       apt-transport-https \
                       --no-install-recommends

# node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
    | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

RUN mkdir /rails_app
WORKDIR /rails_app

COPY Gemfile /rails_app/Gemfile
COPY Gemfile.lock /rails_app/Gemfile.lock
COPY yarn.lock /rails_app/yarn.lock

RUN bundle install --jobs=4 --no-cache
COPY . /rails_app
RUN bundle exec yaml_vault decrypt config/encrypted_secrets.yml \
    -o config/secrets.yml --cryptor=aws-kms \
    --aws-region=ap-northeast-1 \
    --aws-access-key-id=$AWS_ACCESS_KEY_ID \
    --aws-secret-access-key=$AWS_SECRET_ACCESS_KEY

EXPOSE 3000
