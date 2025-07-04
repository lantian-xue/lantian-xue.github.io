# Base image: Ruby with necessary dependencies for Jekyll
FROM ruby:3.2

# Change Ruby mirror
#RUN gem sources --remove https://rubygems.org/ \
# && gem sources --add http://gems.ruby-china.com/ \
# && gem sources -l

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy Gemfile into the container (necessary for `bundle install`)
COPY Gemfile Gemfile.lock ./

# Install bundler and dependencies
RUN gem install bundler:2.3.26 && bundle install

# Command to serve the Jekyll site
CMD ["jekyll", "serve", "-H", "0.0.0.0", "-w", "--config", "_config.yml,_config_docker.yml"]

