output "dev_environment_id" {
  value = confluent_environment.dev.id
}

output "blog_basic_kafka_cluster_id" {
  value = confluent_kafka_cluster.blog_basic.id
}

output "blog_basic_kafka_cluster_bootstrap_endpoint" {
    value = confluent_kafka_cluster.blog_basic.bootstrap_endpoint
}

output "blog_basic_kafka_cluster_rest_endpoint" {
    value = confluent_kafka_cluster.blog_basic.rest_endpoint
}