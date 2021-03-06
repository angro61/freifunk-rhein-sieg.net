FROM nginx:1
MAINTAINER Freifunk Rhein-Sieg e.V. <technik@freifunk-rhein-sieg.net>
EXPOSE 80

WORKDIR /project
RUN apt-get update -y && apt-get install -y git ruby ruby-dev rubygems build-essential cron
RUN gem install bundle
RUN git init && git remote add origin https://github.com/Freifunk-Rhein-Sieg/freifunk-rhein-sieg.net.git
RUN touch /etc/cron.d/update && touch /srv/update.sh && chmod 775 /srv/update.sh && chmod 644 /etc/cron.d/update && touch /var/log/cron.log
RUN echo "cd /project && git pull origin master && /usr/local/bin/jekyll build && rm -rf /usr/share/nginx/html/* && cp -r _site/* /usr/share/nginx/html" > /srv/update.sh
RUN echo "*/30 * * * * root /srv/update.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/update
ENTRYPOINT git fetch && git pull origin master && bundle install && bundle exec jekyll build && rm -rf /usr/share/nginx/html/* && cp -r _site/* /usr/share/nginx/html && echo "ready" && /etc/init.d/cron start && nginx -g "daemon off;"
