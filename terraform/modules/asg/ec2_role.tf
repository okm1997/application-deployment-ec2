# EC2 IAM Instance role in launch template for codedeploy
resource "aws_iam_role" "codedeploy_ec2_role" {
  name               = "CodeDeployEC2Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "codedeploy_policy" {
  name        = "CodeDeployPolicyEC2"
  description = "Policy for CodeDeploy to manage deployments from EC2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codedeploy:*",
          "s3:GetObject",
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_role_attachment" {
  policy_arn = aws_iam_policy.codedeploy_policy.arn
  role       = aws_iam_role.codedeploy_ec2_role.name
}

resource "aws_iam_instance_profile" "codedeploy_instance_profile" {
  name = "CodeDeployInstanceProfile"
  role = aws_iam_role.codedeploy_ec2_role.name
}