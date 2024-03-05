# Base Image
FROM python:3.10-slim-buster
#FROM arm64v8/python:3.10-slim-buster

# Create and set working directory
WORKDIR /app

# Add current directory code to working directory
ADD . /app/


# Set environment variables
# Prevents Python from writing pyc files to disc (equivalent to python -B option)
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONUNBUFFERED 1

# Install pip
#RUN apt-get update && apt-get install -y \
#    gcc \
#    libffi-dev \
#    openssl-dev
#ADD https://bootstrap.pypa.io/get-pip.py get-pip.py
#RUN python3 get-pip.py

# Install pip requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Switching to a non-root user
RUN adduser --disabled-password --gecos '' deeluser
USER deeluser

# Start server
CMD python app.py