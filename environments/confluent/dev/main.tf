# terraform {
#   required_providers {
#     confluent = {
#       source  = "confluentinc/confluent"
#       version = "1.72.0"
#     }
#   }
# }

resource "confluent_environment" "dev" {
  display_name = "DEV"

  stream_governance {
    package = "ESSENTIALS"
  }
}


resource "confluent_kafka_cluster" "blog_basic" {
  display_name = "basic_kafka_cluster"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "eu-west-1"
  basic {}

  environment {
    id = confluent_environment.dev.id
  }
}