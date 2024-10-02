# Codepipeline
resource "aws_codepipeline" "codepipeline" {
  name     = "ec2-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_store_bucket.bucket
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = "okm1997"
        Repo       = "application-deployment-ec2"
        Branch     = "main"
        OAuthToken = var.github_oauth_token
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["source_output"]
      configuration = {
        ApplicationName     = aws_codedeploy_app.deploy_app.name
        DeploymentGroupName = aws_codedeploy_deployment_group.deploy_group.deployment_group_name
      }
    }
  }
}

resource "aws_s3_bucket" "artifact_store_bucket" {
  bucket = "nginx-artifact-store-${terraform.workspace}"
}