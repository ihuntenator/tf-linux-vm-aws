# Terraform deploy for AWS linux instance with tentacle

Install the tentacle at same time as builf linux vm

## the tfvars file

Have a tfvars file per environment to give access to AWS environment and ssh key for vm.

### dev.tfvars

```
access_key = "ACCESS_KEY"
secret_key = "SECRET_KEY"
keyName = "keyname"
keyPath = "/path/to/key"
```

## terraform run
```
terraform init
terraform validate -var-file=de.tfvars
terraform plan -var-file=dev.tfvars -out tf-linux-vm-aws.out
terraform apply "tf-linux-vm-aws.out"
```

When finished:
```
terraform destroy -var-file=dev.tfvars
```
