# Terraform deploy for AWS linux instance with tentacle

Install the tentacle at same time as build linux vm

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
terraform validate
terraform plan -var-file=dev.tfvars -out tf-linux-vm-aws.out
terraform apply "tf-linux-vm-aws.out"
```

## terrarform explore

Create terraform dependency graph in DOT:
```
terraform graph
```

## terraform clean up

When finished:
```
terraform destroy -var-file=dev.tfvars
```
