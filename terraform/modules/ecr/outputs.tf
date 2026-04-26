locals {
  services = [
    "ingestion-api",
    "persist-worker",
    "anomaly-detector",
    "analytics-aggregator",
    "websocket-svc",
    "dashboard"
  ]
}

resource "aws_ecr_repository" "svc" {
  for_each             = toset(local.services)
  name                 = "paysense/${each.key}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Keep last 20 images per repo — prevents unbounded ECR storage cost.
resource "aws_ecr_lifecycle_policy" "svc" {
  for_each   = aws_ecr_repository.svc
  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 20 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 20
      }
      action = { type = "expire" }
    }]
  })
}
