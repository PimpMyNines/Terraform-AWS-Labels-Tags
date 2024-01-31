output "id" {
  value       = module.labels.id
  description = "Disambiguated ID string restricted to `id_length_limit` characters in total"
}

output "enabled" {
  value       = module.labels.enabled
  description = "True if module is enabled, false otherwise"
}

output "namespace" {
  value       = module.labels.namespace
  description = "Normalized namespace"
}

output "tenant" {
  value       = module.labels.tenant
  description = "Normalized tenant"
}

output "environment" {
  value       = module.labels.environment
  description = "Normalized environment"
}

output "name" {
  value       = module.labels.name
  description = "Normalized name"
}

output "stage" {
  value       = module.labels.stage
  description = "Normalized stage"
}

output "delimiter" {
  value       = module.labels.delimiter
  description = "Delimiter between `namespace`, `tenant`, `environment`, `stage`, `name` and `attributes`"
}

output "tags" {
  value       = module.labels.tags
  description = "Normalized Tag map"
}

output "label_order" {
  value       = module.labels.label_order
  description = "The naming order actually used to create the ID"
}

output "regex_replace_chars" {
  value       = module.labels.regex_replace_chars
  description = "The regex_replace_chars actually used to create the ID"
}

output "id_length_limit" {
  value       = module.labels.id_length_limit
  description = "The id_length_limit actually used to create the ID, with `0` meaning unlimited"
}

output "context" {
  value       = module.labels.context
  description = "Normalized context of this module"
}
