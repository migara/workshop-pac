package terraform.policies.security

import input.plan as plan


# Apps that aren't sanctioned
unsanctioned_apps = [
    "ms-ds-smb"
]

deny[msg] {
  some i, j
  r := plan.resource_changes[_]
  r.type == "panos_security_rule_group"
  rule := r.change.after.rule[_]
  rule.applications[i] == unsanctioned_apps[j]
  msg := sprintf("Rule '%v' has an unsanctioned application ID '%v'", [rule.name, rule.applications[i]])
}
