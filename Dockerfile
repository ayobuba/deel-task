# Base Image
FROM arm64v8/python:3.10-slim-buster

# Create and set working directory
WORKDIR /app

# Add current directory code to working directory
ADD . /app/


# Set environment variables
# Prevents Python from writing pyc files to disc (equivalent to python -B option)
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONUNBUFFERED 1

# Install pip requirements
COPY requirements.txt .
RUN python3 -m pip install pip
RUN pip install -r requirements.txt

# Switching to a non-root user
RUN adduser --disabled-password --gecos '' myuser
USER myuser

# Start server
CMD python app.py