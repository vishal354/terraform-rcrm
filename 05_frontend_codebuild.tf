data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com", "codepipeline.amazonaws.com", "codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "example" {
  role   = aws_iam_role.example.name
  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "ec2:*",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = ["arn:aws:ec2:us-east-1:123456789012:network-interface/*"]

    # condition {
    #   test     = "StringEquals"
    #   variable = "ec2:Subnet"

    #   values = [
    #     aws_subnet.example1.arn,
    #     aws_subnet.example2.arn,
    #   ]
    # }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "codedeploy:*",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.my_bucket.arn,
      "${aws_s3_bucket.my_bucket.arn}/*",
      aws_s3_bucket.art_bucket.arn,
      "${aws_s3_bucket.art_bucket.arn}/*",
      aws_s3_bucket.backend_art_bucket.arn,
      "${aws_s3_bucket.backend_art_bucket.arn}/*",
    ]
  }
}


resource "aws_codebuild_project" "tutorial-project" {
  name          = "tutorial-project"
  description   = "test_codebuild_project"
  build_timeout = 5

  service_role = aws_iam_role.example.arn

  artifacts {
    type      = "S3"
    packaging = "NONE"
    location  = aws_s3_bucket.my_bucket.id
    path      = "/"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    # environment_variable {
    #   name  = "SOME_KEY1"
    #   value = "SOME_VALUE1"
    # }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/vishal354/react-crud-web-api.git"
    git_clone_depth = 1
  }

  tags = {
    Environment = "Test"
  }
}