provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "docking_bay" {
  bucket_prefix = "docking-bay-storage-"

  tags = {
    Name                 = "Docking Bay"
    Environment          = "Dev"
    git_commit           = "cf230b4dadee6f4f812170504afe6f7e10129a48"
    git_file             = "terraform/simple_instance/s3.tf"
    git_last_modified_at = "2022-06-23 17:37:53"
    git_last_modified_by = "matt+github@metahertz.co.uk"
    git_modifiers        = "matt+github"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "55ae07bc-8cf3-469f-8b55-46faa9766beb"
  }
}


resource "aws_s3_bucket" "docking_bay_log_bucket" {
  bucket = "docking_bay-log-bucket"
}

resource "aws_s3_bucket_logging" "docking_bay" {
  bucket = aws_s3_bucket.docking_bay.id

  target_bucket = aws_s3_bucket.docking_bay_log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "docking_bay" {
  bucket = aws_s3_bucket.docking_bay.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "docking_bay" {
  bucket = aws_s3_bucket.docking_bay.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "docking_bay" {
  bucket = aws_s3_bucket.docking_bay.id

  versioning_configuration {
    status = "Enabled"
  }
}