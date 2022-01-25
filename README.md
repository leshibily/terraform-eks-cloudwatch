# Terraform EKS CloudWatch

## Prerequisites
1. Install Terraform v1.0.10 or above.
2. (Optional) Update the Terraform S3 backend in versions.tf (only for production).
3. Create a terraform.tfvars file in the root directory. Example below.

## Variables

Below is an example `terraform.tfvars` file that you can use in your deployments:

```ini
region       = "us-west-2"
cluster_name = "demo"
email_id     = "shibilyshukoor@gmail.com"
```

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
```

Make sure to keep the terraform state files safe, as they contain your access keys to the S3 bucket (only when in production).