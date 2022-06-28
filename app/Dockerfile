FROM python:3.8-alpine


RUN apk --update add postgresql-client

WORKDIR /app

RUN pip install pipenv
RUN pipenv install
COPY . /app

CMD [ "/app/run_app.sh"]