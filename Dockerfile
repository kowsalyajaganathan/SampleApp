FROM --platform=linux/amd64 python:3.9

RUN apt-get update
RUN apt-get install -y --no-install-recommends nginx supervisor

# RUN apt-get update
# RUN apt-get install -y --no-install-recommends build-essential python3 python3-pip python3-dev supervisor

RUN pip3 install uwsgi

COPY ./requirements.txt /project/requirements.txt

RUN pip3 install -r /project/requirements.txt

RUN useradd --no-create-home nginx

#RUN rm /etc/nginx/sitedockers-enabled/default
RUN rm -r /root/.cache

COPY nginx.conf /etc/nginx/
COPY nginx-app.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/

COPY . /project

WORKDIR /project

CMD ["/usr/bin/supervisord"]
