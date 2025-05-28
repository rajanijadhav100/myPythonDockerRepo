# Use the official Python image from the Docker Hub with an Alpine variant
FROM python:3.9-alpine

# Declare a build argument
ARG BUILD_VERSION

# Add a label with the build version to change the image content
LABEL build_version=$BUILD_VERSION

# Set the working directory in the container
WORKDIR /app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy files required for the app to run
COPY app.py /usr/src/app/

COPY templates/index.html /usr/src/app/templates/

EXPOSE 5000

# run the application
CMD ["python", "/usr/src/app/app.py"]
