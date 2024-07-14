# syntax=docker/dockerfile:1

FROM python:3.10.4-slim

WORKDIR /app

RUN useradd -m python && \
    chown python:python -R /app && \
    apt-get update && \
    apt-get -y install libpq-dev gcc 

USER python

EXPOSE 8000

ENV PYTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1

COPY --chown=python:python requirements.txt .

RUN python -m pip install -U pip && \
    python -m pip install -r requirements.txt

COPY --chown=python:python . .

CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
