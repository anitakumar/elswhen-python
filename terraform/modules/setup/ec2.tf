locals {
  ami_name      = "ami-0843a4d6dc2130849"
  instance_type = "t2.micro"
  key_name      = "mywebservm"
  user_data     = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install python docker -y
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
sudo echo "<html><body>Hello World</body></html>" > /etc/nginx/html/index.html
sudo systemctl enable docker
sudo systemctl start docker
sudo mkdir -p /home/ec2-user/containerize
sudo aws s3 sync s3://containerize /home/ec2-user/containerize
sudo chown root:root /home/ec2-user/containerize/nginx/nginx.conf
sudo chown root:root /home/ec2-user/containerize/nginx/files
sudo chown root:root /home/ec2-user/containerize/nginx/files/*
# sudo groupadd -r nginx -g 433 
# sudo useradd -u 431 -r -g nginx -s /sbin/nologin -c "Docker user for nginx" nginx
#Download get-pip to current directory. It won't install anything, as of now
sudo curl -O https://bootstrap.pypa.io/get-pip.py
#Use python3.6 to install pip
sudo python3 get-pip.py
sudo docker-compose up -d
sudo docker-compose up -d


EOF
}


module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "containerize-instance"
  ami                         = local.ami_name
  instance_type               = local.instance_type
  iam_instance_profile        = aws_iam_instance_profile.this.id
  associate_public_ip_address = true
  key_name                    = "mywebservm"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.this.id]
  subnet_id                   = module.vpc.public_subnets[0]
  user_data                   = local.user_data
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "containerize"
  }
}


# resource "null_resource" "copy-files" {

#   connection {
#     type     = "ssh"
#     host     = module.ec2_instance.public_ip
#     user     = "ec2-user"
#     private_key = file("${path.module}/security/mywebservm.pem")
#   }

#   provisioner "file" {
#     source      = "../../../app/Dockerfile"
#     destination = "/home/ec2-user/containerize/app/"
#   }

#   provisioner "file" {
#     source      = "../../../app/src/server.py"
#     destination = "/home/ec2-user/containerize/app/src"
#   }

#   provisioner "file" {
#     source      = "../../../app/src/requirements.txt"
#     destination = "/home/ec2-user/containerize/app/src"
#   }

#   provisioner "file" {
#     source      = "../../../nginx"
#     destination = "/home/ec2-user/containerize"
#   }



# }