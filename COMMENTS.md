
## Containerize a Python application

### Overview

#### Security
1. Using non-privileged access in both python and nginx containers
2. A user app created in app container
3. A user:group nginx:nginx created in the nginx docker container 
4. Additional permissions applied for files in the docker nginx container

#### Implementation:
1. Using volume mounts for secrets and nginx.conf in the docker-compose.yml. This limits the number of layers in the Dockerfile
2. The python is running behind the gunicorn server
3. /etc/nginx/nginx.conf contains forwarding from http to https in the 2 server sections under http.
4. Uses Green Unicorn server for application server to deploy the python application and is applicable to production.
Link to the gunicorn documentation here[
https://docs.gunicorn.org/en/latest/settings.html]
5. Automation can be initiated via terraform/modules/setup/deploy.sh to AWS. The terraform files are avialable in the terraform folder.
#### hot loading
This has been applied in docker-compose file using the CHOKIDAR_USERPOLLING

### Considerations and Improvements
1. More logging required from both servers for debugging and monitoring purposes
2. Using docker secrets or a better secrets store or using AWS parameter store or vault
3.Add additional setting to restrict ips to access the unicorn server
4. The terraform code needs to be modularised.

