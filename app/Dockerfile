FROM python:3.8-alpine


RUN apk --update add postgresql-client

WORKDIR /app

RUN pip install pipenv
RUN pipenv install
RUN apt-get install build-dep python-psycopg2
RUN pip install psycopg2-binary
COPY . /app
RUN pipenv sync

CMD [ "/app/run_app.sh"]