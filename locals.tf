# https://developer.hashicorp.com/terraform/language/values/locals

locals {
  tags = {
    environment = "prod"
    department  = "finance"
    source      = "terraform"
  }
  envs = jsonencode({ for tuple in regexall("(.*)=(.*)", file(".env")) : tuple[0] => sensitive(tuple[1]) }) # a way to parse vars in .env file to here
}
