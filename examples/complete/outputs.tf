output "labels_context" {
  value       = module.labels.context
  description = "Context Output for Labels Module"
}

output "route53_context" {
  value       = module.route53_labels.context
  description = "Context Output for Route53"
}

output "ecs_context" {
  value       = module.ecs_labels.context
  description = "Context Output for ECS"
}