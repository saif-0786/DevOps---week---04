# DevOps---week---04
# DevOps Week 04 – Infrastructure as Code & Configuration Management

## 📌 Overview

This project demonstrates **Infrastructure as Code (IaC)** and **Configuration Management** using **Terraform** and **Ansible**.

* **Terraform** is used to provision and manage infrastructure.
* **Ansible** is used to configure and manage servers.
* Together, they help create repeatable, automated, and consistent DevOps environments.

---

## 🎯 Objectives

The objectives of this practical assignment are:

* Understand Infrastructure as Code (IaC)
* Install and configure Terraform
* Configure a Terraform provider
* Create a basic Terraform configuration
* Use Terraform variables and outputs
* Understand Terraform state
* Practice Terraform commands
* Install and configure Ansible
* Create an Ansible inventory
* Create Ansible playbooks
* Use Ansible modules
* Install a package using Ansible
* Create a user using Ansible
* Start and manage a service using Ansible
* Understand Terraform vs Ansible
* Understand the Terraform + Ansible workflow

---

## 🛠️ Technologies Used

| Tool         | Purpose                  |
| ------------ | ------------------------ |
| Terraform    | Infrastructure as Code   |
| Ansible      | Configuration Management |
| Linux/Ubuntu | Execution Environment    |
| Git          | Version Control          |
| GitHub       | Source Code Repository   |
| Nginx        | Example Web Service      |

---

## 📁 Project Structure

```text
DevOps-Week-04/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── ansible/
│   ├── inventory
│   └── playbook.yml
│
├── screenshots/
│   ├── terraform-init.png
│   ├── terraform-plan.png
│   ├── terraform-apply.png
│   ├── terraform-destroy.png
│   ├── terraform-state.png
│   ├── ansible-inventory.png
│   ├── ansible-playbook.png
│   └── server-verification.png
│
├── README.md
└── IaC_Configuration_Management_Short_Report.pdf
```

---

# 🏗️ Infrastructure as Code

Infrastructure as Code is the practice of managing infrastructure using configuration files instead of manually creating and configuring resources.

### Benefits

* Automation
* Consistency
* Repeatability
* Version control
* Faster deployment
* Reduced manual errors
* Easier infrastructure management

---

# 🌱 Terraform

Terraform is an Infrastructure as Code tool used to provision and manage infrastructure using declarative configuration files.

Terraform configuration files normally use the `.tf` extension.

### Terraform Workflow

```text
Write Configuration
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
Verify Infrastructure
        ↓
terraform destroy
```

---

# 🔌 Terraform Provider

A provider allows Terraform to interact with an external platform or service.

Examples:

* Azure
* AWS
* Google Cloud
* Kubernetes
* GitHub
* Local resources

Example:

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}
```

---

# 📦 Terraform Variables

Variables allow Terraform configurations to be reused without changing the main configuration.

### `variables.tf`

```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}
```

### `terraform.tfvars`

```hcl
environment = "development"
```

---

# 📤 Terraform Outputs

Outputs display useful information after Terraform creates resources.

Example:

```hcl
output "created_file" {
  description = "Path of the file created by Terraform"
  value       = local_file.devops_demo.filename
}
```

---

# 💾 Terraform State

Terraform state stores information about resources managed by Terraform.

The default local state file is:

```text
terraform.tfstate
```

Check Terraform state:

```bash
terraform state list
```

View a specific resource:

```bash
terraform state show local_file.devops_demo
```

> In production environments, Terraform state should generally be stored using a secure remote backend with appropriate access controls.

---

# 🧩 Terraform Modules

Terraform modules are reusable collections of Terraform configuration files.

Modules help:

* Avoid duplicate code
* Standardize infrastructure
* Improve maintainability
* Reuse infrastructure configurations
* Support multiple environments

Example:

```text
modules/
├── network/
├── virtual-machine/
└── storage/
```

---

# ⚙️ Terraform Commands

### Initialize

```bash
terraform init
```

Initializes the Terraform working directory and downloads required providers.

### Format

```bash
terraform fmt
```

Formats Terraform configuration files.

### Validate

```bash
terraform validate
```

Checks whether the Terraform configuration is valid.

### Plan

```bash
terraform plan
```

Shows the changes Terraform intends to make.

### Apply

```bash
terraform apply
```

Creates or updates infrastructure.

### Destroy

```bash
terraform destroy
```

Removes resources managed by Terraform.

---

# 🔧 Ansible

Ansible is an automation and configuration-management tool used to configure servers and automate operational tasks.

Ansible can be used to:

* Install packages
* Create users
* Manage services
* Copy files
* Configure applications
* Deploy applications

Ansible is generally agentless and commonly uses SSH to manage Linux servers.

---

# 📋 Ansible Inventory

An inventory defines the servers managed by Ansible.

Example `inventory`:

```ini
[webservers]
localhost ansible_connection=local
```

Check inventory:

```bash
ansible-inventory -i inventory --list
```

Test connectivity:

```bash
ansible all -i inventory -m ping
```

---

# 📜 Ansible Playbook

An Ansible playbook is a YAML file containing tasks that describe how servers should be configured.

Example `playbook.yml`:

```yaml
---
- name: Configure Web Server
  hosts: webservers
  become: true

  tasks:

    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Create DevOps user
      user:
        name: devopsuser
        state: present
        shell: /bin/bash

    - name: Start Nginx service
      service:
        name: nginx
        state: started
        enabled: true
```

---

# 🧱 Ansible Modules

Ansible modules perform individual tasks.

Examples:

| Module    | Purpose                  |
| --------- | ------------------------ |
| `apt`     | Install/manage packages  |
| `user`    | Create/manage users      |
| `service` | Manage services          |
| `copy`    | Copy files               |
| `command` | Execute commands         |
| `file`    | Manage files/directories |

---

# ▶️ Running the Ansible Playbook

Check playbook syntax:

```bash
ansible-playbook -i inventory playbook.yml --syntax-check
```

Run the playbook:

```bash
ansible-playbook -i inventory playbook.yml
```

Verify Nginx:

```bash
systemctl status nginx
```

Verify the user:

```bash
id devopsuser
```

Test the web server:

```bash
curl http://localhost
```

---

# 🔄 Terraform vs Ansible

| Terraform                        | Ansible                                  |
| -------------------------------- | ---------------------------------------- |
| Infrastructure provisioning      | Configuration management                 |
| Creates infrastructure           | Configures infrastructure                |
| Uses `.tf` files                 | Uses YAML playbooks                      |
| Uses providers                   | Uses modules                             |
| Maintains state                  | Does not use Terraform-style state       |
| Manages infrastructure lifecycle | Manages server/application configuration |
| Example: Create VM               | Example: Install Nginx                   |

### Simple Explanation

```text
Terraform → Create the infrastructure

Ansible   → Configure the infrastructure
```

---

# 🔗 Terraform + Ansible Workflow

Terraform and Ansible can be used together in a DevOps environment.

```text
                 GitHub
                    │
                    ▼
                Terraform
                    │
                    ▼
          Provision Infrastructure
                    │
                    ▼
                Server / VM
                    │
                    ▼
                 Ansible
                    │
                    ▼
            Configure Server
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
       Package     User     Service
       Install    Create     Start
```

### Example

**Terraform:**

```text
Create VM
Create Network
Create IP
```

**Ansible:**

```text
Connect to VM
Install Nginx
Create User
Configure Server
Start Nginx
```

---

# 📸 Practical Screenshots

The following screenshots were captured/prepared as part of the practical exercise:

* Terraform initialization
* Terraform plan
* Terraform apply
* Terraform state
* Terraform destroy
* Ansible inventory
* Ansible ping
* Ansible playbook execution
* Server/service verification

Place the screenshots inside the `screenshots/` directory.

---

# ✅ Best Practices

1. Always review `terraform plan` before `terraform apply`.
2. Keep Terraform and Ansible code under Git version control.
3. Do not hard-code passwords or secrets.
4. Use Terraform modules for reusable infrastructure.
5. Use meaningful Ansible inventory groups.
6. Test configurations before using them in production.
7. Protect Terraform state because it may contain sensitive infrastructure information.
8. Carefully test AI-generated IaC code before using it.

---

# 📝 Conclusion

Terraform and Ansible are complementary DevOps tools.

**Terraform** is mainly responsible for provisioning and managing infrastructure, while **Ansible** is mainly responsible for configuring and maintaining servers.

Using Terraform and Ansible together provides a repeatable, automated, and consistent approach to building DevOps environments.

---

## 👨‍💻 Project Information

**Topic:** Infrastructure as Code & Configuration Management

**Tools:** Terraform, Ansible, Linux, Git, GitHub

**Assignment:** DevOps Weekly Task – 2026

**Author:** Saif Rahman Shaik
