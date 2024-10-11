provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "louiebucket"  # Replace with your unique bucket name
  force_destroy = true  # Optional: allows bucket deletion with contents
}