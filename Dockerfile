FROM ubuntu:trusty
MAINTAINER Travis Elnicky telnicky@instructure.com

RUN apt-get update && apt-get install -y -q \
    build-essential \
    git \
    libssl-dev \
    libsqlite3-dev \
    nodejs \
    ruby-dev \
    sqlite3 \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/* \
 && gem install bundler --no-ri --no-rdoc

RUN git clone https://github.com/telnicky/mailcatcher.git
WORKDIR mailcatcher
RUN bundle install

EXPOSE 1025
EXPOSE 1080

ENTRYPOINT ["bundle", "exec", "mailcatcher", "-f"]
CMD ["--ip", "0.0.0.0"]
