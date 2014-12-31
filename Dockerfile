FROM debian:wheezy

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    git \
    libxml2-dev \
    python2.7 \
    build-essential \
    make \
    gcc \
    python-dev \
    locales \
    python-pip


RUN pip install virtualenv

RUN cd / && virtualenv -p /usr/bin/python2.7 venv

ENV VENV="/venv/"

RUN source /venv/bin/activate

RUN pip install pyramid Jinja2 pyramid-debugtoolbar pyramid-jinja2 setuptools

RUN mkdir -p /app
ADD . /app
WORKDIR /app



RUN cd /app && $VENV/bin/python setup.py develop

RUN cd /app && $VENV/bin/python setup.py test -q

EXPOSE 6543

ENTRYPOINT ["$VENV/bin/pserve", "/app/development.ini"]