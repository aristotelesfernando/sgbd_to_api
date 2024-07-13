FROM postgres

RUN apt-get update && apt-get install -y \
    python3-full \
    python3-pip \
    python3-httplib2 \
    postgresql-contrib \
    postgresql-plpython3-16 \
    procps \
    nano

ENV POSTGRES_PASSWORD=afo@030571

EXPOSE 5432
