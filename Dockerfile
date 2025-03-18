# Use an official Python runtime as a base image
FROM python:3.9-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask (since we use it in app.py)
RUN pip install flask

# Expose port 5000 for the Flask application
EXPOSE 5000

# Define an environment variable for Flask
ENV FLASK_APP=app.py

# Run the application
CMD ["python", "app.py"]
 
