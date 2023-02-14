# Use an existing image as the base image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy the code into the container
COPY react-crud /app/react-crud
COPY admin /app/admin

# Install npm
RUN apt-get update && apt-get install -y npm

# Install python and dependencies
RUN apt-get update && apt-get install -y python3 python3-pip

WORKDIR /app/admin

RUN pip3 install -r requirements.txt

# Install packages for the React app
WORKDIR /app/react-crud
RUN npm install


# Set environment variable
ENV NODE_OPTIONS="--openssl-legacy-provider"

RUN npm run build


# Collect static files for the Django app
WORKDIR /app/admin
RUN python3 manage.py collectstatic --noinput

WORKDIR /app/react-crud

EXPOSE 3000

# Start the app
CMD ["npm", "start"]

