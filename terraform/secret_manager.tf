resource "aws_kms_key" "sm" {
  description             = "KMS key for Secret Manager"
  deletion_window_in_days = 10
}

resource "aws_secretsmanager_secret" "secret" {
  description = "Database URL"
  kms_key_id  = aws_kms_key.sm.arn
  name        = "DATABASE_URL"

}


resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = module.db.db_instance_endpoint
  depends_on = [
    module.db
  ]
}
