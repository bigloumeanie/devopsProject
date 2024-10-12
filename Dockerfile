# use an official python runtime as a parent image
FROM python:3.9-slim

# set working directory in container
WORKDIR /app

# copy current directory contents into container
COPY . /app/

# install any required dependencies listed in the container at /app
RUN pip install --no-cache-dir -r requirements.txt

# install flask from requirements
# RUN pip install flask

# make port 5000 available to world outside the container
EXPOSE 5001

#define env variables
ENV NAME=DockerApp

#run app.py when container launches
CMD ["python", "app.py"]
