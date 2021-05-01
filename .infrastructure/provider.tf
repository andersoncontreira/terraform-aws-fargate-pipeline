provider "aws" {
    profile =                 var.aws_profile
    shared_credentials_file = "~/.aws/credentials"
    region =                  var.aws_region
}
