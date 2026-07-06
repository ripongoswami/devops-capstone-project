# Start from the python:3.9-slim image
FROM python:3.9-slim

# Establish a WORKDIR of /app
WORKDIR /app

# COPY the requirements.txt file into the working directory
COPY requirements.txt .

# RUN the pip command to install the requirements using the --no-cache-dir option
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package into the working directory
COPY service/ ./service/

# Create a non-root user called theia, change ownership recursively, and switch to theia
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# EXPOSE port 8080
EXPOSE 8080

# Create a CMD statement that runs gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]