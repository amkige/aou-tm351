FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

ENV POSTGRES_USER=test
ENV POSTGRES_PASSWORD=test
ENV POSTGRES_DB=tm351test

RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    postgresql \
    postgresql-contrib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /home/requirements.txt
RUN pip3 install --no-cache-dir -r /home/requirements.txt

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add - \
    && echo "deb [ arch=amd64 trusted=yes ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends mongodb-org \
    && mkdir -p /data/db \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create the PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';\"" && \
    su - postgres -c "createdb -O $POSTGRES_USER $POSTGRES_DB"

COPY dotfiles /root
COPY notebooks /home/notebooks

EXPOSE 27351 5432 8888

# Start PostgreSQL, MongoDB and Jupyter
CMD ["bash", "-c", "service postgresql start && mongod --port 27351 --fork --logpath /var/log/mongodb/mongod.log && jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --notebook-dir=/home/notebooks"]