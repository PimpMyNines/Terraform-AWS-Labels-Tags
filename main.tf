resource "time_static" "creation" {}

locals {
  # Defaults
  enabled             = var.enabled == null ? var.context.enabled : var.enabled
  regex_replace_chars = coalesce(var.regex_replace_chars, var.context.regex_replace_chars, "/[^-a-zA-Z0-9]/")
  delimiter           = coalesce(var.delimiter, var.context.delimiter, "-")
  id_length_limit     = coalesce(var.id_length_limit, var.context.id_length_limit, 63)
  key_case            = coalesce(var.key_case, var.context.key_case, "lower")
  value_case          = coalesce(var.value_case, var.context.value_case, "lower")
  labels_as_tags      = coalesce(var.labels_as_tags, var.context.labels_as_tags, true)
  label_order         = coalesce(var.label_order, var.context.label_order, ["namespace", "name", "environment", "stage", "attributes"])
  tags                = coalesce(var.tags, var.context.tags, {})

  # AWS
  aws_region     = coalesce(var.aws_region, var.context.aws_region)
  aws_account_id = coalesce(var.aws_account_id, var.context.aws_account_id)
  aws_partition  = coalesce(var.aws_partition, var.context.aws_partition)

  # Standard Prefixes
  prefix_external_service  = coalesce(var.prefix_external_service, var.context.prefix_external_service, "organization/external/service")
  prefix_internal_service  = coalesce(var.prefix_internal_service, var.context.prefix_internal_service, "organization/internal/service")
  prefix_external_employee = coalesce(var.prefix_external_employee, var.context.prefix_external_employee, "organization/external/employee")
  prefix_internal_employee = coalesce(var.prefix_internal_employee, var.context.prefix_internal_employee, "organization/internal/employees")


  # Create a map with labels and use var.context as defaults
  labels = {
    namespace   = var.namespace != null && var.namespace != "" ? var.namespace : var.context.namespace
    tenant      = var.tenant != null && var.tenant != "" ? var.tenant : var.context.tenant
    environment = var.environment != null && var.environment != "" ? var.environment : var.context.environment
    stage       = var.stage != null && var.stage != "" ? var.stage : var.context.stage
    name        = var.name != null && var.name != "" ? var.name : var.context.name
    attributes  = length(var.attributes) > 0 ? join(local.delimiter, var.attributes) : join(local.delimiter, var.context.attributes)
  }

  # Filter out null or empty values from labels
  filtered_labels = { for key, value in local.labels : key => value if value != null && value != "" }
  cleaned_labels = {
    for key, value in local.filtered_labels :
    key => replace(value, local.regex_replace_chars, length(local.filtered_labels) > 1 ? local.delimiter : "")
  }





  # Normalize filtered labels and apply case transformations
  normalized_ordered_labels = [
    for label_key in local.label_order :
    {
      key = local.key_case == "none" ? label_key : local.key_case == "title" ? title(label_key) : local.key_case == "upper" ? upper(label_key) : lower(label_key)
      value = contains(keys(local.cleaned_labels), label_key) ? (
        local.value_case == "none" ? local.cleaned_labels[label_key] : local.key_case == "title" ? title(local.cleaned_labels[label_key]) :
        local.key_case == "upper" ? upper(local.cleaned_labels[label_key]) : lower(local.cleaned_labels[label_key])
      ) : null
    }
  ]

  # Generate ID using normalized and sorted labels
  # Generate ID using normalized and sorted labels, filtering out null values
  generated_id = join(local.delimiter, [for label in local.normalized_ordered_labels : label.value if label.value != null])


  normalized_labels_tags = {
    for label in local.normalized_ordered_labels :
    label.key => label.value
  }

  # Tags
  additional_tags = {
    terraform_managed = coalesce(var.tag_terraform_managed, "true")
    monitored_by      = coalesce(var.tag_monitored_by, "cloudwatch")
    git_repo          = coalesce(var.tag_git_repo, "https://github.com/PimpMyNines/Terraform-Module-Labels")
    creation_time     = coalesce(var.tag_creation_time, time_static.creation.rfc3339)
    last_modified_by  = coalesce(var.tag_last_modified_by, data.aws_caller_identity.current.arn)
  }


  # Filter out null values from additional_tags to create non_empty_tags
  non_empty_tags = { for key, value in local.additional_tags : key => value if value != null }

  # Normalize additional tags
  normalized_additional_tags = {
    for key, value in local.non_empty_tags :
    key => local.value_case == "none" ? value : local.key_case == "title" ? title(value) : local.key_case == "upper" ? upper(value) : lower(value)
  }

  # Merge normalized tags with normalized additional tags, if labels_as_tags == true; else use additional_tags only
  all_tags = local.labels_as_tags ? merge(local.normalized_additional_tags, local.normalized_labels_tags, local.tags) : local.tags

  # Context of this label to pass to other label modules
  output_context = {
    enabled = local.enabled
    # Defaults
    regex_replace_chars = local.regex_replace_chars
    delimiter           = local.delimiter
    id_length_limit     = local.id_length_limit
    key_case            = local.key_case
    value_case          = local.value_case
    labels_as_tags      = local.labels_as_tags
    label_order         = local.label_order
    tags                = local.all_tags

    # AWS
    aws_region     = local.aws_region
    aws_account_id = local.aws_account_id
    aws_partition  = local.aws_partition

    # Standard Prefixes
    prefix_external_service  = local.prefix_external_service
    prefix_internal_service  = local.prefix_internal_service
    prefix_external_employee = local.prefix_external_employee
    prefix_internal_employee = local.prefix_internal_employee

    # Labels
    namespace   = local.labels.namespace
    tenant      = local.labels.tenant
    environment = local.labels.environment
    stage       = local.labels.stage
    name        = local.labels.name
    attributes  = compact(split(local.delimiter, local.labels.attributes))
  }
}
