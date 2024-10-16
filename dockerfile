FROM ubuntu:16.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=test
ENV POSTGRES_PASSWORD=test
ENV POSTGRES_DB=tm351test

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    git \
    libgeos-dev \
    msttcorefonts \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    postgresql \
    postgresql-contrib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-3.4.asc | apt-key add - && \
    echo "deb [ arch=amd64 trusted=yes ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && apt-get install -y --no-install-recommends mongodb-org && \
    mkdir -p /data/db && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Import accidents database into MongoDB
ADD accidents.tar.gz /tmp
RUN mongod --fork --logpath /dev/null && \
    mongorestore --db accidents /tmp/accidents && \
    pkill mongod && rm -rf /tmp/accidents

# Create the PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';\"" && \
    su - postgres -c "createdb -O $POSTGRES_USER $POSTGRES_DB" && \
    service postgresql stop

# Copy config and notebooks
COPY config /root
ADD notebooks.tar.gz /home

# Enable nbextension and trust jupyter notebooks
RUN jupyter contrib nbextension install --user && \
    jupyter trust /home/notebooks/**/*.ipynb

# Expose necessary ports
EXPOSE 8888

# Start PostgreSQL, MongoDB, and Jupyter
CMD ["bash", "-c", "service postgresql start && mongod --port 27351 --fork --logpath /dev/null && jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --notebook-dir=/home/notebooks"]
