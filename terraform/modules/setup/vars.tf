# variable "user_data" {
#     default = " << EOF
# #!/bin/bash	\n
# sudo yum update -y	\
# sudo yum install nginx -y	\
# sudo echo "<html><body>Hello World</body></html>" > /etc/nginx/html/index.html	\n
# sudo systemctl enable nginx	\
# sudo systemctl start nginx \
# EOF"

# }
variable "region" {
  default = "eu-west-1"
} 