# AWS S3 Bucket Terraform module

Terraform module which creates an S3 bucket with logging and a policy for secure connections only

## Usage

```hcl
module "s3" {
  source                = "JoelsHub/s3/aws"
  version               = "1.0.0"
  bucket_key            = "aws_bucket"
  logging_bucket        = "aws_log_bucket"
  create_logging_bucket = false # Uses the logging_bucket name to create the logging bucket
  public_access         = false # If false, this apply public access restrictions to the bucket
}
```