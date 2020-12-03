# Terraform deploy for AWS linux instance with tentacle

Install the tentacle at same time as builf linux vm

```
terraform init
terraform plan -var-file=dev.tfvars -out tf-linux-vm-aws.out
terraform apply "tf-linux-vm-aws.out"
```

When finished:
```
terraform destroy "tf-linux-vm-aws.out"
```
