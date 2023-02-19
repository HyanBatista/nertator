FROM python:3.10.10-alpine3.17
LABEL maintainer="hyanbatista42@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY requirements.txt /tmp/requirements.txt
COPY requirements.dev.txt /tmp/requirements.dev.txt
COPY nertator /nertator
WORKDIR /nertator
EXPOSE 8000

ARG DEV=false
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /venv/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        nertator-user

ENV PATH="/venv/bin:$PATH"

USER nertator-user
