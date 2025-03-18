# cloudengine_ass


# Flask App Deployment on AWS using Terraform and Docker
Prerequisites

-Git 
-Docker 
-AWS CLI 
-Terraform
-Python

app.py 
![image](https://github.com/user-attachments/assets/01114096-3b01-44ad-b9e3-46ebabd6a77a)

# Step 1:
### Clone the Repository
```bash
git clone https://github.com/PrakashThangasamy/cloudengine_ass.git
cd flask-cloudengine
```

### Install Dependencies (For Local Testing)
```bash
pip install flask
python app.py  # Runs the app locally at http://127.0.0.1:5000/
```

### Expected Output:

![image](https://github.com/user-attachments/assets/04bb4e85-9fa0-4a22-9dcb-96dc239b72fc)

```json
{"message":"Hello CloudEngine Labs - from Python Flask!"}
```

## Step 2 Dockerizing the Application

### Create a Dockerfile
Ensure your `Dockerfile` contains the following:
```dockerfile
# Use an official Python runtime as a base image
FROM python:3.9-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . /app

# Install Flask
RUN pip install flask

# Expose port 5000 for the Flask application
EXPOSE 5000

# Define an environment variable for Flask
ENV FLASK_APP=app.py

# Run the application
CMD ["python", "app.py"]
```

 ### Step 3: Build the Docker Image

```bash
docker build -t prakashthangasamy/flask-cloudengine .
```

### Run the Docker Container Locally
```bash
docker run -p 5000:5000 prakashthangasamy/flask-cloudengine
```

### Push the Docker Image to Docker Hub
```bash
docker login

docker push prakashthangasamy/flask-cloudengine
```
![image](https://github.com/user-attachments/assets/dba5b716-730a-461a-a297-46cd2c5628ae)

## Step 4 Deploying to AWS with Terraform

### Create `main.tf` File

### Initialize Terraform
```bash
terraform init
```

### Apply Terraform Configuration
```bash
terraform apply -auto-approve
```

This will:
- Create an AWS EC2 instance
- Install Docker on the instance
- Pull and run the Flask application container
![image](https://github.com/user-attachments/assets/ef561a33-66d7-4557-b606-9a085d381def)
![image](https://github.com/user-attachments/assets/97135941-705c-45b7-b878-65afcd845bcc)

## step 5 Accessing the Deployed Flask App
Open your browser and visit:
```plaintext
http://<EC2_PUBLIC_IP>:5000
```
Expected Output:
![image](https://github.com/user-attachments/assets/0a827822-cdec-44ea-b80a-f0cb65fad589)

```json
{"message":"Hello CloudEngine Labs - from Python Flask!"}
```

