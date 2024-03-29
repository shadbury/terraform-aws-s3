resource "aws_s3_bucket_policy" "bucket_policy" {
    count = var.create_logging_bucket ? 0 : 1
  bucket = var.bucket_key
  policy = jsonencode(
    {
          Id        = "BUCKET-POLICY"
          Statement = [
              {
                  Action    = "s3:*"
                  Condition = {
                      Bool = {
                          "aws:SecureTransport" = "false"
                        }
                    }
                  Effect    = "Deny"
                  Principal = "*"
                  Resource  = [
                      "arn:aws:s3:::${var.bucket_key}/*",
                      "arn:aws:s3:::${var.bucket_key}",
                    ]
                  Sid       = "AllowSSLRequestsOnly"
                },
            ]
          Version   = "2012-10-17"
        }
    )
}

resource "aws_s3_bucket_policy" "logging_bucket_policy" {
    depends_on = [
      aws_s3_bucket.logging_bucket
    ]
    count = var.create_logging_bucket ? 1 : 0
    bucket = var.logging_bucket
    policy = jsonencode(
    {
          Id        = "BUCKET-POLICY"
          Statement = [
              {
                  Action    = "s3:*"
                  Condition = {
                      Bool = {
                          "aws:SecureTransport" = "false"
                        }
                    }
                  Effect    = "Deny"
                  Principal = "*"
                  Resource  = [
                      "arn:aws:s3:::${var.logging_bucket}/*",
                      "arn:aws:s3:::${var.logging_bucket}",
                    ]
                  Sid       = "AllowSSLRequestsOnly"
                },
            ]
          Version   = "2012-10-17"
        }
    )
}
