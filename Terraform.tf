provider "aws" {
  region = "us-east-1"
}


resource "aws_security_group" "allow_ssh_docker" {
  name        = "allow_ssh_docker"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # Allow HTTP (Flask app on port 5000)
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all (secure it in production)
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "flask_app" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = "Prakash"
  security_groups = [aws_security_group.allow_ssh_docker.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Pull the Docker image
              sudo docker pull prakashthangasamy/flask-cloudengine
              
              # Run the container
              sudo docker run -d -p 80:5000 prakashthangasamy/flask-cloudengine
              
              # Ensure container runs on reboot
              echo "@reboot root docker start \$(docker ps -aq)" | sudo tee -a /etc/crontab
              EOF

  tags = {
    Name = "FlaskAppInstance"
  }
}