FROM python:2-alpine
MAINTAINER Jonathan Meyer <jon@gisjedi.com>

ENV DJANGOPYPI2_ROOT /opt/djangopypi2

RUN mkdir -p $DJANGOPYPI2_ROOT && \
    pip install setuptools-git && \
    pip install djangopypi2 gunicorn  && \
    pip install django==1.6

RUN manage-pypi-site syncdb --noinput && \
    manage-pypi-site collectstatic --noinput && \
    manage-pypi-site loaddata initial

EXPOSE 8000

CMD ["gunicorn_django", "djangopypi2.website.settings", "-b", "0.0.0.0:8000"]
