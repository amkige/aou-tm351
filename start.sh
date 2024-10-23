#!/bin/bash

# Start PostgreSQL
service postgresql start 1> /dev/null &

# Start MongoDB
mongod --port 27351 1> /dev/null &

# Start OpenRefine
/opt/openrefine/refine -p 3333 -i 0.0.0.0 1> /dev/null &

# Start Jupyter Notebook
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root --notebook-dir=/home/notebooks