terraform {
  required_providers {
    panos = {
      source  = "PaloAltoNetworks/panos"
      version = "1.11.0"
    }
  }

  cloud {
    organization = "panw-bridgecrew"

    workspaces {
      name = "pac"
    }
  }
}

provider "panos" {
  hostname = "20.94.144.82"
  username = "panadmin"
  password = "yzrk0zsojMdsq_uf"
}

resource "panos_security_rule_group" "this" {
  device_group = "DG"

  rule {
    name                  = "Allow bizdev to dmz"
    source_zones          = ["any"]
    source_addresses      = ["any"]
    source_users          = ["any"]
    # hip_profiles          = ["any"]
    destination_zones     = ["any"]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
  rule {
    name                  = "Deny sales to engx"
    source_zones          = ["any"]
    source_addresses      = ["any"]
    source_users          = ["any"]
    # hip_profiles          = ["any"]
    destination_zones     = ["any"]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "deny"
  }

  lifecycle {
    create_before_destroy = true
  }
}