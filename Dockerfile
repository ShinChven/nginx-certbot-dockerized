FROM ubuntu

WORKDIR /etc/nginx/conf.d
COPY nginx-template.sh /usr/local/bin/nginx-template
RUN chmod +x /usr/local/bin/nginx-template
RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx certbot python3-certbot-nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
