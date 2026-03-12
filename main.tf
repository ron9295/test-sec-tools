# Configure the AWS Provider
# Replace "us-east-1" with your desired region
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- ECR Repository Resource ---
# Creates a private repository to store the 'myproject' Docker image
resource "aws_ecr_repository" "app_repo" {
  name                 = "myproject-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "MyProject"
    App     = "DjangoDRF"
  }
}

# --- Output the ECR Repository URI ---
# This URI is used to tag and push the Docker image
output "ecr_repository_uri" {
  description = "The URI of the ECR repository"
  value       = aws_ecr_repository.app_repo.repository_url
}

