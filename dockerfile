# Use the official Ubuntu 16.04 LTS image as the base
FROM ubuntu:16.04

# Set environment variables to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

ENV POSTGRES_USER=test
ENV POSTGRES_PASSWORD=test
ENV POSTGRES_DB=tm351test

# Update package list and install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-apt \
    python3-magic \
    postgresql \
    postgresql-contrib \
    && rm -rf /var/lib/apt/lists/*

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add - \
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list \
    && apt-get update \
    && apt-get install -y --allow-unauthenticated mongodb-org \
    && mkdir -p /data/db

# Copy requirements.txt into the image
COPY requirements.txt /home/requirements.txt

# Install Jupyter and Python packages from requirements.txt
RUN pip3 install --upgrade pip==20.3.4 && pip3 install -r /home/requirements.txt

# Create the PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';\"" && \
    su - postgres -c "createdb -O $POSTGRES_USER $POSTGRES_DB"

# Copy notebooks
ADD notebooks /home/notebooks

# Set Jupyter notebooks configuration
RUN mkdir -p /home/.jupyter && \
    echo "c.NotebookApp.allow_origin = '*'" >> /home/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_credentials = True" >> /home/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> /home/.jupyter/jupyter_notebook_config.py

# Expose necessary ports
EXPOSE 27017 5432 8888

# Start services and Jupyter
CMD ["bash", "-c", "service postgresql start && mongod --fork --logpath /var/log/mongodb/mongod.log && jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --config=/home/.jupyter/jupyter_notebook_config.py --notebook-dir=/home/notebooks"]

# Set the working directory
WORKDIR /home
