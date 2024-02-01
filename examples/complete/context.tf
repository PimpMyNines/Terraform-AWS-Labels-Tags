module "labels" {
  source = "../../"

  enabled     = "true"
  namespace   = "generic"
  tenant      = "engineering"
  environment = "live"
  stage       = "qa"
  name        = "example"
  delimiter   = "-"
  attributes  = ["testing"]
  tags = {
    "foo" = "bar"
  }
  label_order         = ["namespace", "name", "environment", "stage"]
  regex_replace_chars = null
  id_length_limit     = 45
  key_case            = "lower"
  value_case          = "lower"
  labels_as_tags      = "true"

  # Standard Prefixes
  prefix_external_service  = "pimpmynines/external/service"
  prefix_internal_service  = "pimpmynines/internal/service"
  prefix_external_employee = "pimpmynines/external/employee"
  prefix_internal_employee = "pimpmynines/internal/employees"

}

module "route53_labels" {
  source = "../../"

  namespace   = "generic"
  tenant      = "engineering"
  environment = "live"
  stage       = "qa"
  name        = "route53"

  context = module.labels.context

}

module "ecs_labels" {
  source = "../../"

  namespace   = "generic"
  tenant      = "engineering"
  environment = "live"
  stage       = "qa"
  name        = "ecs"

  context = module.labels.context

}

# Module Configuration
variable "context" {
  type = any
  default = {
    enabled                  = true
    namespace                = null
    tenant                   = null
    environment              = null
    stage                    = null
    name                     = null
    delimiter                = null
    attributes               = []
    tags                     = {}
    additional_tag_map       = {}
    regex_replace_chars      = null
    label_order              = []
    id_length_limit          = null
    key_case                 = null
    value_case               = null
    descriptor_formats       = {}
    labels_as_tags           = true
    aws_region               = null
    aws_account_id           = null
    aws_partition            = null
    tag_terraform_managed    = null
    tag_monitored_by         = null
    tag_git_repo             = null
    tag_creation_time        = null
    tag_last_modified_by     = null
    prefix_external_service  = null
    prefix_internal_service  = null
    prefix_external_employee = null
    prefix_internal_employee = null
  }

  description = <<-EOT
    Single object for setting the entire context at once.
    See the description of individual variables for details.
    Leave string and numeric variables as `null` to use the default value.
    Individual variable settings (non-null) override settings in the context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT
}

# Enable/Disable the Module
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

# Namespace Variable
variable "namespace" {
  type        = string
  default     = null
  description = "ID element. Usually an abbreviation of your organization name."
}

# Tenant Variable
variable "tenant" {
  type        = string
  default     = null
  description = "ID element _(Rarely used, not included by default)_. A customer identifier."
}

# Environment Variable
variable "environment" {
  type        = string
  default     = null
  description = "ID element. Usually used for region or role."
}

# Stage Variable
variable "stage" {
  type        = string
  default     = null
  description = "ID element. Usually used to indicate role."
}

# Name Variable
variable "name" {
  type        = string
  default     = null
  description = "ID element. Usually the component or solution name."
}

# Delimiter Variable
variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between ID elements."
  validation {
    condition     = var.delimiter != null
    error_message = "Delimiter cannot be an empty string."
  }
}

# Attributes Variable
variable "attributes" {
  type        = list(string)
  default     = []
  description = "ID element. Additional attributes to add to `id` suffix."
}

# Labels as Tags Variable
variable "labels_as_tags" {
  type        = bool
  default     = true
  description = "Set as 'false' to prevent labels from being used as tags"

  validation {
    condition = can(
      var.labels_as_tags == true || var.labels_as_tags == false
    )
    error_message = "labels_as_tags must be either true or false."
  }
}

# Tags Variable
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to be applied."
}

# Label Order Variable
variable "label_order" {
  type        = list(string)
  default     = ["namespace", "environment", "stage", "name", "attributes"]
  description = "The order in which the labels appear in the `id`."
  validation {
    condition     = length(var.label_order) > 0
    error_message = "Label order must not be empty."
  }
}

# Regex Replace Chars Variable
variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Terraform regular expression (regex) string to define characters to be replaced by the delimiter."
}

# ID Length Limit Variable
variable "id_length_limit" {
  type        = number
  default     = 0
  description = "Limit `id` to this many characters (minimum 6)."
  validation {
    condition     = var.id_length_limit == 0 || var.id_length_limit >= 6
    error_message = "ID length limit must be >= 6 if supplied, or 0 for an unlimited length."
  }
}

# Key Case Variable
variable "key_case" {
  type        = string
  default     = "title"
  description = "Controls the letter case of the `tags` keys (label names) for tags generated by this module."
  validation {
    condition     = contains(["lower", "title", "upper", "none"], var.key_case)
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
  }
}

# Value Case Variable
variable "value_case" {
  type        = string
  default     = "lower"
  description = "Controls the letter case of ID elements (labels) as included in `id`, set as tag values, and output by this module individually."
  validation {
    condition     = contains(["lower", "title", "upper", "none"], var.value_case)
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
  }
}

# AWS Prefix for External Services Variable
variable "prefix_external_service" {
  type        = string
  description = "Prefix for external service resources"
  default     = null
}

# AWS Prefix for Internal Services Variable
variable "prefix_internal_service" {
  type        = string
  description = "Prefix for internal service resources"
  default     = null
}

# AWS Prefix for External Employees Variable
variable "prefix_external_employee" {
  type        = string
  description = "Prefix for external employee resources"
  default     = null
}

# AWS Prefix for Internal Employees Variable
variable "prefix_internal_employee" {
  type        = string
  description = "Prefix for internal employee resources"
  default     = null
}

# Tag for Terraform Managed Resources Variable
variable "tag_terraform_managed" {
  type        = string
  description = "Tag used for identifying Resources based on whether they are managed by Terraform"
  default     = null
}

# Tag for Monitored By Variable
variable "tag_monitored_by" {
  type        = string
  description = "Tag used for identifying monitoring platforms to use for resources"
  default     = null
}

# Git Repository Tag Variable
variable "tag_git_repo" {
  type        = string
  description = "Git Repository for making changes to this configuration"
  default     = null
}

# Department Tag Variable
variable "tag_department" {
  type        = string
  description = "Department tag"
  default     = null
}

# AWS Region Variable
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = null
}

# AWS Account ID Variable
variable "aws_account_id" {
  type        = string
  description = "AWS Account Id"
  default     = null
}

# AWS Partition Variable
variable "aws_partition" {
  type        = string
  description = "AWS Partition"
  default     = null
}

# Tag for Creation Time Variable
variable "tag_creation_time" {
  type        = string
  description = "Time and Date of Resource Creation, Used for Lifecycle Management"
  default     = null
}

# Tag for Last Modified By Variable
variable "tag_last_modified_by" {
  type        = string
  description = "AWS Principal who last deployed changes to the resource(s)"
  default     = null
}
