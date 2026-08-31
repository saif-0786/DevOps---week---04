output "created_file" {
  description = "Path of the file created by Terraform"
  value       = local_file.devops_demo.filename
}
