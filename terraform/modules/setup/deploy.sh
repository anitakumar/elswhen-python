#!/bin/bash
terraform apply -auto-approve
cd ../../../

aws s3 cp nginx s3://containerize/nginx --recursive
aws s3 cp ~/Documents/dev/containerize/app/src/server.py s3://containerize/app/src/server.py
aws s3 cp ~/Documents/dev/containerize/app/src/gunicorn.py s3://containerize/app/src/gunicorn.py
aws s3 cp ~/Documents/dev/containerize/app/Dockerfile s3://containerize/app/Dockerfile
aws s3 cp ~/Documents/dev/containerize/app/.dockerignore s3://containerize/app/.dockerignore
aws s3 cp ~/Documents/dev/containerize/app/src/requirements.txt s3://containerize/app/src/requirements.txt
aws s3 cp ~/Documents/dev/containerize/docker-compose.yml s3://containerize/docker-compose.yml


