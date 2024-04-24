terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.72.0"
    }
  }
}

provider "confluent" {
  # Default configurations, if any
}