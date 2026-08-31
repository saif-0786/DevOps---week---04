terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "devops_demo" {
  filename = "${path.module}/devops-demo.txt"

  content = <<-EOT
  Infrastructure as Code Demo
  Created using Terraform
  Environment: ${var.environment}
  EOT
}
