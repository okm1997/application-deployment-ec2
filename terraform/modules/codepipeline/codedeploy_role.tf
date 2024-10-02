# Code Deploy Role
resource "aws_iam_role" "code_deploy_role" {
  name = "CodeDeployRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "code_deploy_policy" {
  name = "CodeDeployPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:Get*",
          "s3:List*",
          "autoscaling:DeleteLifecycleHook",
          "autoscaling:RecordLifecycleActionHeartbeat",
          "autoscaling:CreateLifecycleHook",
          "autoscaling:PutLifecycleHook",
          "autoscaling:CompleteLifecycleAction",
          "autoscaling:Describe*",
          "autoscaling:EnterStandby",
          "autoscaling:ExitStandby",
          "autoscaling:UpdateAutoScalingGroup",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:DeleteAlarms"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "code_deploy_policy_attachment" {
  role       = aws_iam_role.code_deploy_role.name
  policy_arn = aws_iam_policy.code_deploy_policy.arn
}