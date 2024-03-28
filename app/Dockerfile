# your code goes here ...
FROM python:3.7.11-slim
RUN groupadd -r app -g 433 && \
    useradd -u 431 -r -g app -s /sbin/nologin -c "Docker image user" app
WORKDIR  /app

COPY src/requirements.txt .

RUN pip install -r requirements.txt

COPY src/server.py  .

COPY src/gunicorn.py  .

USER app

EXPOSE 8080 443

# CMD ["python3", "server.py", "--host=0.0.0.0", "--port=8000"]
CMD ["gunicorn","--config", "gunicorn.py", "server:app"]