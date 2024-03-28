workers = 1

threads = 4

timeout = 100
keepalive = 2
bind = '0.0.0.0:8080'

pidfile = 'pidfile'
errorlog = 'errorlog'
loglevel = 'info'
accesslog = 'accesslog'
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'

forwarded_allow_ips = '*'


#secure_scheme_headers = {
#        'X-FORWARDED-PROTOCOL': 'ssl',
#        'X-FORWARDED-PROTO': 'https',
#        'X-FORWARDED-SSL': 'on'
#}
proxy_allow_ips ='*'

#[https]
#protocol = proxy
#accept  = 443
#connect = 80
#certfile = /etc/ssl/certs/localhost.crt
#keyfile = /etc/ssl/certs/localhost.key