# your code goes here ...
# FROM nginx:stable-alpine3.17-slim
FROM nginx
# RUN addgroup -r nginx -g 433 && \
#     adduser  -u 431 -r -g nginx -s /sbin/nologin -c "Docker image user" nginx
# Remove default Nginx configuration
# RUN rm /etc/nginx/conf.d/default.conf

# Harden Nginx permissions
RUN chmod 644 /etc/nginx/nginx.conf \
     && chmod 644 /etc/nginx/nginx.conf \
     && chown -R nginx:nginx /etc/nginx \
     && chmod -R 755 /var/log/nginx \
     && chgrp -R nginx /var/cache/nginx /var/run /var/log/nginx && \
    chmod -R 777 /var

# Reduce Nginx attack surface by dropping root privileges

# USER nginx
EXPOSE 80 443 
CMD ["nginx", "-g", "daemon off;"]