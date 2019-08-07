#######################################################################
##### AWS S3 - Creates a bucket to store build artifacts & objects#####
#######################################################################

# allowed_origins = [${join("https://",var.bucket_name)}]

resource "aws_s3_bucket" "bucket" {
  bucket 		= "${var.bucket_name}"
  region		= "${var.region}"
  acl    		= "private"
  force_destroy = true
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["${var.https_bucket_name}"]
	expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
  versioning {
    enabled = true
  }
}