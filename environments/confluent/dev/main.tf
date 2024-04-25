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

resource "confluent_service_account" "blog_sa" {
  display_name = "blog_sa"
  description  = "Service Account for blog example app(s)"
}

resource "confluent_api_key" "blog_kafka_api_key" {
  display_name = "blog_kafka_api_key"
  description  = "Kafka API Key that is owned by 'blog' service account"
  owner {
    id          = confluent_service_account.blog_sa.id
    api_version = confluent_service_account.blog_sa.api_version
    kind        = confluent_service_account.blog_sa.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.blog_basic.id
    api_version = confluent_kafka_cluster.blog_basic.api_version
    kind        = confluent_kafka_cluster.blog_basic.kind

    environment {
      id = confluent_environment.dev.id
    }
  }
}

data "github_repository" "cloud_iac_repo" {
  full_name = "javierholguera/Cloud-IAC"
}

resource "github_actions_environment_secret" "blog_kafka_api_key_id" {
  repository        = data.github_repository.cloud_iac_repo.name
  environment       = "dev" # name of the GH environment the secret is loaded into (different from Repo Secrets)
  secret_name       = "blog_kafka_api_key_id"
  plaintext_value   = confluent_api_key.blog_kafka_api_key.id
}

resource "github_actions_environment_secret" "blog_kafka_api_key_secret" {
  repository        = data.github_repository.cloud_iac_repo.name
  environment       = "dev" # name of the GH environment the secret is loaded into (different from Repo Secrets)
  secret_name       = "blog_kafka_api_key_secret"
  plaintext_value   = confluent_api_key.blog_kafka_api_key.secret
}
