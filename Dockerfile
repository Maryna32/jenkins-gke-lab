FROM python:2.7

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app

COPY django/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir psycopg2

COPY django/notejam /app/

WORKDIR /app
EXPOSE 5000

CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]