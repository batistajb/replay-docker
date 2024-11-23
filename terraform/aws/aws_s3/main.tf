provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "replay_bucket" {
  bucket = "replay-bucket-production"

  tags = {
    Name        = "ReplayBucket"
    Environment = "Production"
  }
}

resource "aws_iam_user" "s3_user" {
  name = "s3-user"
}

resource "aws_iam_policy" "s3_user_policy" {
  name        = "s3-user-policy"
  description = "Policy for S3 user to access the replay bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:HeadBucket"
        ],
        Resource = "arn:aws:s3:::${aws_s3_bucket.replay_bucket.bucket}"
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${aws_s3_bucket.replay_bucket.bucket}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_user_policy_attachment" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_user_policy.arn
}

resource "aws_iam_access_key" "s3_user_access_key" {
  user = aws_iam_user.s3_user.name
}

output "s3_user_access_key_id" {
  value = aws_iam_access_key.s3_user_access_key.id
}

output "s3_user_secret_access_key" {
  value     = aws_iam_access_key.s3_user_access_key.secret
  sensitive = true
}