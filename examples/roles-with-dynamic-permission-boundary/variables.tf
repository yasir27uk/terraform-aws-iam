variable "policies" {
  description = "A list of dictionaries defining all policies."
  type = list(object({
    name = string                    # Name of the policy
    path = optional(string)          # Defaults to 'var.policy_path' if variable is set to null
    desc = optional(string)          # Defaults to 'var.policy_desc' if variable is set to null
    file = string                    # Path to json or json.tftpl file of policy
    vars = optional(map(string), {}) # Policy template variables {key = val, ...}
  }))
  default = []
}

variable "roles" {
  description = "A list of dictionaries defining all roles."
  type = list(object({
    name                 = string                    # Name of the role
    instance_profile     = optional(string)          # Name of the instance profile
    path                 = optional(string)          # Defaults to 'var.role_path' if variable is set to null
    desc                 = optional(string)          # Defaults to 'var.role_desc' if variable is set to null
    trust_policy_file    = string                    # Path to file of trust/assume policy. Will be templated if vars are passed.
    trust_policy_vars    = optional(map(string), {}) # Policy template variables {key = val, ...}
    permissions_boundary = optional(string)          # ARN to a policy used as permissions boundary (or null/empty)
    permission_boundary_policies = optional(list(object({
      file = string                    # Path to json or json.tftpl file of policy statements
      vars = optional(map(string), {}) # Policy template variables {key = val, ...}
    })), [])
    policies    = optional(list(string), []) # List of names of policies (must be defined in var.policies)
    policy_arns = optional(list(string), []) # List of existing policy ARN's
    inline_policies = optional(list(object({
      name = string                    # Name of the inline policy
      file = string                    # Path to json or json.tftpl file of policy
      vars = optional(map(string), {}) # Policy template variables {key = val, ...}
    })), [])
  }))
  default = []
  validation {
    condition = length(var.roles) > 0 ? alltrue([
      for role in var.roles : !(role.permissions_boundary != null && length(role.permission_boundary_policies) > 0)
    ]) : true
    error_message = "Either permission_boundary or permission_boundary_policies value should be set, but not both."
  }
}

variable "role_perm_bound_policy_path" {
  type        = string
  description = "The path under which to create the permission boundary. You can use a single path, or nest multiple paths as if they were a folder structure. For example, you could use the nested path /division_abc/subdivision_xyz/product_1234/engineering/ to match your company's organizational structure."
  default     = "/"
}
