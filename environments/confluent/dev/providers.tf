terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.72.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "confluent" {
  # Default configurations, if any
}

# Configure the GitHub Provider
provider "github" {
  //token = var.github_token
}