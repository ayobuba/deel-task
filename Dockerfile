# Base Image
FROM python:3.11-slim-buster
#FROM arm64v8/python:3.10-slim-buster
RUN apt-get -q -y update
RUN apt-get install -y gcc

# Create and set working directory
WORKDIR /app

# Add current directory code to working directory
ADD . /app/


# Set environment variables
# Prevents Python from writing pyc files to disc (equivalent to python -B option)
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr (equivalent to python -u option)
ENV PYTHONUNBUFFERED 1

ENV DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

# existing code...

# Copy entrypoint.sh
COPY ./entrypoint.sh /app/entrypoint.sh

# Make sure the entrypoint.sh file is executable
RUN chmod +x /app/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

# existing code...
# Install pip requirements
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Switching to a non-root user
RUN adduser --disabled-password --gecos '' deeluser
USER deeluser

# Start server
CMD flask db upgrade && python app.py