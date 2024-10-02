# Code deploy
resource "aws_codedeploy_app" "deploy_app" {
  name = "nginx-deploy-app"
}

resource "aws_codedeploy_deployment_group" "deploy_group" {
  app_name              = aws_codedeploy_app.deploy_app.name
  deployment_group_name = "nginx-deploy-group"
  service_role_arn      = aws_iam_role.code_deploy_role.arn

  autoscaling_groups = [var.asg_name]

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
}