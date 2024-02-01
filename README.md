# Terraform-Module-Standard-Labels-Tags

## Summary
This is a simple module, designed to accept label and tag inputs to automatically generate standardized tags and ID 
labels. Using this module will output the derived values as outputs to be used as shown below.

### Example Usage

```hcl
module "labels" {
  source  = "../../"

  enabled             = "true"
  namespace           = "generic"
  tenant              = "engineering"
  environment         = "live"
  stage               = "qa"
  name                = "example"
  delimiter           = "-"
  attributes          = ["testing"]
  tags                = {
    "foo" = "bar"
  }
  label_order         = ["namespace", "name", "environment", "stage"]
  regex_replace_chars = null
  id_length_limit     = 45
  key_case      = "lower"
  value_case    = "lower"
  labels_as_tags      = "true"

  # Standard Prefixes
  prefix_external_service  = "pimpmynines/external/service"
  prefix_internal_service  = "pimpmynines/internal/service"
  prefix_external_employee = "pimpmynines/external/employee"
  prefix_internal_employee = "pimpmynines/internal/employees"

}

module "route53_labels" {
  source  = "../../"

  namespace           = "generic"
  tenant              = "engineering"
  environment         = "live"
  stage               = "qa"
  name                = "route53"

  context = module.labels.context

}

module "ecs_labels" {
  source  = "../../"

  namespace           = "generic"
  tenant              = "engineering"
  environment         = "live"
  stage               = "qa"
  name                = "ecs"

  context = module.labels.context

}
```
### Example Output
```hcl
Outputs:

ecs_context = {
  "attributes" = tolist([
    "testing",
  ])
  "aws_account_id" = "365834568155"
  "aws_partition" = "aws"
  "aws_region" = "us-east-1"
  "delimiter" = "-"
  "enabled" = true
  "environment" = "live"
  "id_length_limit" = 0
  "key_case" = "title"
  "label_order" = tolist([
    "namespace",
    "environment",
    "stage",
    "name",
    "attributes",
  ])
  "labels_as_tags" = true
  "name" = "ecs"
  "namespace" = "generic"
  "prefix_external_employee" = "pimpmynines/external/employee"
  "prefix_external_service" = "pimpmynines/external/service"
  "prefix_internal_employee" = "pimpmynines/internal/employees"
  "prefix_internal_service" = "pimpmynines/internal/service"
  "regex_replace_chars" = "/[^a-zA-Z0-9-]/"
  "stage" = "qa"
  "tags" = tomap({
    "Attributes" = "Testing"
    "Environment" = "Live"
    "Name" = "Ecs"
    "Namespace" = "Generic"
    "Stage" = "Qa"
    "creation_time" = "2024-02-01T22:15:35Z"
    "git_repo" = "Https://Github.Com/PimpMyNines/Terraform-Module-Labels"
    "last_modified_by" = "Arn:Aws:Sts::365834568155:Assumed-Role/AWSReservedSSO_AWSAdministratorAccess_e634b7397975f32f/Slopresto+Aws@Pimpmynines.Com"
    "monitored_by" = "Cloudwatch"
    "terraform_managed" = "True"
  })
  "tenant" = "engineering"
  "value_case" = "lower"
}
labels_context = {
  "attributes" = tolist([
    "testing",
  ])
  "aws_account_id" = "365834568155"
  "aws_partition" = "aws"
  "aws_region" = "us-east-1"
  "delimiter" = "-"
  "enabled" = true
  "environment" = "live"
  "id_length_limit" = 45
  "key_case" = "lower"
  "label_order" = tolist([
    "namespace",
    "name",
    "environment",
    "stage",
  ])
  "labels_as_tags" = true
  "name" = "example"
  "namespace" = "generic"
  "prefix_external_employee" = "pimpmynines/external/employee"
  "prefix_external_service" = "pimpmynines/external/service"
  "prefix_internal_employee" = "pimpmynines/internal/employees"
  "prefix_internal_service" = "pimpmynines/internal/service"
  "regex_replace_chars" = "/[^-a-zA-Z0-9]/"
  "stage" = "qa"
  "tags" = tomap({
    "creation_time" = "2024-02-01t22:15:35z"
    "environment" = "live"
    "foo" = "bar"
    "git_repo" = "https://github.com/pimpmynines/terraform-module-labels"
    "last_modified_by" = "arn:aws:sts::365834568155:assumed-role/awsreservedsso_awsadministratoraccess_e634b7397975f32f/slopresto+aws@pimpmynines.com"
    "monitored_by" = "cloudwatch"
    "name" = "example"
    "namespace" = "generic"
    "stage" = "qa"
    "terraform_managed" = "true"
  })
  "tenant" = "engineering"
  "value_case" = "lower"
}
route53_context = {
  "attributes" = tolist([
    "testing",
  ])
  "aws_account_id" = "365834568155"
  "aws_partition" = "aws"
  "aws_region" = "us-east-1"
  "delimiter" = "-"
  "enabled" = true
  "environment" = "live"
  "id_length_limit" = 0
  "key_case" = "title"
  "label_order" = tolist([
    "namespace",
    "environment",
    "stage",
    "name",
    "attributes",
  ])
  "labels_as_tags" = true
  "name" = "route53"
  "namespace" = "generic"
  "prefix_external_employee" = "pimpmynines/external/employee"
  "prefix_external_service" = "pimpmynines/external/service"
  "prefix_internal_employee" = "pimpmynines/internal/employees"
  "prefix_internal_service" = "pimpmynines/internal/service"
  "regex_replace_chars" = "/[^a-zA-Z0-9-]/"
  "stage" = "qa"
  "tags" = tomap({
    "Attributes" = "Testing"
    "Environment" = "Live"
    "Name" = "Route53"
    "Namespace" = "Generic"
    "Stage" = "Qa"
    "creation_time" = "2024-02-01T22:15:35Z"
    "git_repo" = "Https://Github.Com/PimpMyNines/Terraform-Module-Labels"
    "last_modified_by" = "Arn:Aws:Sts::xxxxxxxxx:Assumed-Role/xxxxxxxxxx/MyUser@MyDomain.Com"
    "monitored_by" = "Cloudwatch"
    "terraform_managed" = "True"
  })
  "tenant" = "engineering"
  "value_case" = "lower"
}

```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider\_time) | 0.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [time_static.creation](https://registry.terraform.io/providers/hashicorp/time/0.10.0/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes to add to `id` suffix. | `list(string)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account Id | `string` | `null` | no |
| <a name="input_aws_partition"></a> [aws\_partition](#input\_aws\_partition) | AWS Partition | `string` | `"aws"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting the entire context at once.<br>See the description of individual variables for details.<br>Leave string and numeric variables as `null` to use the default value.<br>Individual variable settings (non-null) override settings in the context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "aws_account_id": null,<br>  "aws_partition": null,<br>  "aws_region": null,<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "key_case": null,<br>  "label_order": [],<br>  "labels_as_tags": true,<br>  "name": null,<br>  "namespace": null,<br>  "prefix_external_employee": null,<br>  "prefix_external_service": null,<br>  "prefix_internal_employee": null,<br>  "prefix_internal_service": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tag_creation_time": null,<br>  "tag_git_repo": null,<br>  "tag_last_modified_by": null,<br>  "tag_monitored_by": null,<br>  "tag_terraform_managed": null,<br>  "tags": {},<br>  "tenant": null,<br>  "value_case": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements. | `string` | `"-"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region or role. | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6). | `number` | `0` | no |
| <a name="input_key_case"></a> [key\_case](#input\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module. | `string` | `"title"` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels appear in the `id`. | `list(string)` | <pre>[<br>  "namespace",<br>  "environment",<br>  "stage",<br>  "name",<br>  "attributes"<br>]</pre> | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set as 'false' to prevent labels from being used as tags | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name. | `string` | `null` | no |
| <a name="input_prefix_external_employee"></a> [prefix\_external\_employee](#input\_prefix\_external\_employee) | Prefix for external employee resources | `string` | `null` | no |
| <a name="input_prefix_external_service"></a> [prefix\_external\_service](#input\_prefix\_external\_service) | Prefix for external service resources | `string` | `null` | no |
| <a name="input_prefix_internal_employee"></a> [prefix\_internal\_employee](#input\_prefix\_internal\_employee) | Prefix for internal employee resources | `string` | `null` | no |
| <a name="input_prefix_internal_service"></a> [prefix\_internal\_service](#input\_prefix\_internal\_service) | Prefix for internal service resources | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string to define characters to be replaced by the delimiter. | `string` | `"/[^a-zA-Z0-9-]/"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role. | `string` | `null` | no |
| <a name="input_tag_creation_time"></a> [tag\_creation\_time](#input\_tag\_creation\_time) | Time and Date of Resource Creation, Used for Lifecycle Management | `string` | `null` | no |
| <a name="input_tag_department"></a> [tag\_department](#input\_tag\_department) | Department tag | `string` | `null` | no |
| <a name="input_tag_git_repo"></a> [tag\_git\_repo](#input\_tag\_git\_repo) | Git Repository for making changes to this configuration | `string` | `null` | no |
| <a name="input_tag_last_modified_by"></a> [tag\_last\_modified\_by](#input\_tag\_last\_modified\_by) | AWS Principal who last deployed changes to the resource(s) | `string` | `null` | no |
| <a name="input_tag_monitored_by"></a> [tag\_monitored\_by](#input\_tag\_monitored\_by) | Tag used for identifying monitoring platforms to use for resources | `string` | `null` | no |
| <a name="input_tag_terraform_managed"></a> [tag\_terraform\_managed](#input\_tag\_terraform\_managed) | Tag used for identifying Resources based on whether they are managed by Terraform | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be applied. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier. | `string` | `null` | no |
| <a name="input_value_case"></a> [value\_case](#input\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`, set as tag values, and output by this module individually. | `string` | `"lower"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_context"></a> [context](#output\_context) | Normalized context of this module |
| <a name="output_delimiter"></a> [delimiter](#output\_delimiter) | Delimiter between `namespace`, `tenant`, `environment`, `stage`, `name` and `attributes` |
| <a name="output_enabled"></a> [enabled](#output\_enabled) | True if module is enabled, false otherwise |
| <a name="output_environment"></a> [environment](#output\_environment) | Normalized environment |
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID string restricted to `id_length_limit` characters in total |
| <a name="output_id_length_limit"></a> [id\_length\_limit](#output\_id\_length\_limit) | The id\_length\_limit actually used to create the ID, with `0` meaning unlimited |
| <a name="output_label_order"></a> [label\_order](#output\_label\_order) | The naming order actually used to create the ID |
| <a name="output_name"></a> [name](#output\_name) | Normalized name |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Normalized namespace |
| <a name="output_regex_replace_chars"></a> [regex\_replace\_chars](#output\_regex\_replace\_chars) | The regex\_replace\_chars actually used to create the ID |
| <a name="output_stage"></a> [stage](#output\_stage) | Normalized stage |
| <a name="output_tags"></a> [tags](#output\_tags) | Normalized Tag map |
| <a name="output_tenant"></a> [tenant](#output\_tenant) | Normalized tenant |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
