data "aws_caller_identity" "current" {}

resource "aws_iam_instance_profile" "this" {
  name = "test_profile"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "ssm_access_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "this_s3" {
  name               = "s3s_role_for_ec2"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.this.json
}


# resource "aws_s3_bucket_policy" "example_bucket_policy" {
#   bucket = "example-bucket"

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.this_s3.name}"
#         },
#         "Action": [
#           "s3:GetObject",
#           "s3:ListBucket"
#         ],
#         "Resource": [
#           "arn:aws:s3:::example-bucket",
#           "arn:aws:s3:::example-bucket/*"
#         ]
#       }
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "this_s3" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}