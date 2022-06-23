resource "aws_ecr_repository" "orca_python_docker" {
  name                 = "orca_python_docker"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
