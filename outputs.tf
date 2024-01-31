output "id" {
  value       = local.generated_id
  description = "Disambiguated ID string restricted to `id_length_limit` characters in total"
}

output "enabled" {
  value       = local.enabled
  description = "True if module is enabled, false otherwise"
}

output "namespace" {
  value       = local.labels.namespace
  description = "Normalized namespace"
}

output "tenant" {
  value       = local.labels.tenant
  description = "Normalized tenant"
}

output "environment" {
  value       = local.labels.environment
  description = "Normalized environment"
}

output "name" {
  value       = local.labels.name
  description = "Normalized name"
}

output "stage" {
  value       = local.labels.stage
  description = "Normalized stage"
}

output "delimiter" {
  value       = local.delimiter
  description = "Delimiter between `namespace`, `tenant`, `environment`, `stage`, `name` and `attributes`"
}

output "tags" {
  value       = local.tags
  description = "Normalized Tag map"
}

output "label_order" {
  value       = local.label_order
  description = "The naming order actually used to create the ID"
}

output "regex_replace_chars" {
  value       = local.regex_replace_chars
  description = "The regex_replace_chars actually used to create the ID"
}

output "id_length_limit" {
  value       = local.id_length_limit
  description = "The id_length_limit actually used to create the ID, with `0` meaning unlimited"
}

output "context" {
  value       = local.output_context
  description = "Normalized context of this module"
}
