# set path for permission boundary
role_perm_bound_policy_path = "/perm-boundaries/"

roles = [
  {
    name              = "ROLE-DYNAMIC-BOUNDARIES-EXAMPLE-1"
    trust_policy_file = "data/trust-policy-file.json"
    trust_policy_vars = {
      ACCOUNT_ID = "608780100653",
      ROLE_NAME  = "LOGIN-TEST-DYNAMIC-BOUNDARIES-1"
    }
    policies        = []
    inline_policies = []
    policy_arns     = []
    permission_boundary_policies = [
      {
        file = "data/boundary-example1.json.tftpl"
        vars = {
          aws_account_id = "1234567890"
        }
      },
      {
        file = "data/boundary-example2.json.tftpl"
      }
    ]
  },
  {
    name              = "ROLE-DYNAMIC-BOUNDARIES-EXAMPLE-2"
    trust_policy_file = "data/trust-policy-file.json"
    trust_policy_vars = {
      ACCOUNT_ID = "608780100653",
      ROLE_NAME  = "LOGIN-TEST-DYNAMIC-BOUNDARIES-2"
    }
    policies    = []
    policy_arns = []
    permission_boundary_policies = [
      {
        file = "data/boundary-example1.json.tftpl"
        vars = {
          aws_account_id = "1234567890",
        }
      }
    ]
  },
  {
    name                 = "ROLE-PERMISSION-BOUNDARY-WITHOUT-POLICIES"
    trust_policy_file    = "data/trust-policy-file.json"
    permissions_boundary = "arn:aws:iam::aws:policy/PowerUserAccess"
    policy_arns          = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  },
]
