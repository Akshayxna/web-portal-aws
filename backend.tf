terraform {
  backend "s3" {
    bucket       = "ak-web-portal-project" 
    key          = "dev/web-portal-projectterraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    # dynamodb_table = "terraform-lock-table"
  }
}