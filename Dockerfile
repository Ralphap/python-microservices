FROM python:3.9
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install Node.js
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g npm@latest

# Copy the requirements.txt file to the container
COPY requirements.txt /app/requirements.txt

# Install the required packages
RUN pip install -r requirements.txt
