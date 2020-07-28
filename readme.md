## Create PI Monitoring Project

1. terraform apply --target=aws_default_vpc.default --auto-approve
2. terraform apply --auto-approve

## Destroy PI Monitoring Project

1. terraform destroy
2. aws secretsmanager delete-secret --secret-id efsid --force-delete-without-recovery
