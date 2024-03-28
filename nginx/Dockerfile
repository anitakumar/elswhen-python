# your code goes here ...
FROM nginx

RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
# COPY files/localhost.crt /etc/nginx/files/localhost.crt
# COPY files/localhost.key /etc/nginx/files/localhost.key

RUN groupadd -r nginx -g 433 && \
    useradd -u 431 -r -g nginx -s /sbin/nologin -c "Docker image user" nginx
# Remove default Nginx configuration
# RUN rm /etc/nginx/conf.d/default.conf

# Harden Nginx permissions
RUN chmod 644 /etc/nginx/nginx.conf \
     && chmod 600 /etc/nginx/files \
     && chmod 600 /etc/nginx/files/localhost.crt \
     && chmod 600 /etc/nginx/files/localhost.key \
     && chmod 644 /etc/nginx/nginx.conf \
     && chown -R nginx:nginx /etc/nginx \
     && chown nginx:nginx /etc/nginx/files/localhost.crt \
     && chown nginx:nginx /etc/nginx/files/localhost.key \
     && chmod -R 755 /var/log/nginx
RUN chgrp -R nginx /var/cache/nginx /var/run /var/log/nginx && \
    chmod -R 777 /var

# Reduce Nginx attack surface by dropping root privileges

USER nginx
EXPOSE 80 443 
CMD ["nginx", "-g", "daemon off;"]