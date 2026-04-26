.PHONY: up down plan fmt cost

ENV ?= dev

## Bring up all infra for ENV (default: dev)
up:
	cd paysense-app/terraform/envs/$(ENV) && terraform init && terraform apply -auto-approve

## Tear down ALL infra for ENV — destroys EKS, Kinesis, Dynamo, Timestream, VPC.
## Run this every night to avoid billing.
down:
	cd paysense-app/terraform/envs/$(ENV) && terraform destroy \
	  -target=module.eks \
	  -target=module.kinesis \
	  -target=module.dynamodb \
	  -target=module.timestream \
	  -target=module.vpc \
	  -auto-approve

## Terraform plan only — no changes
plan:
	cd paysense-app/terraform/envs/$(ENV) && terraform plan

## Format all Terraform
fmt:
	cd paysense-app/terraform && terraform fmt -recursive

## Show last 7 days of AWS spend (cross-platform — uses Python)
cost:
	python3 -c "\
import subprocess, datetime; \
end = datetime.date.today().isoformat(); \
start = (datetime.date.today() - datetime.timedelta(days=7)).isoformat(); \
subprocess.run(['aws','ce','get-cost-and-usage', \
  '--time-period','Start='+start+',End='+end, \
  '--granularity','DAILY','--metrics','UnblendedCost', \
  '--query','ResultsByTime[*].[TimePeriod.Start,Total.UnblendedCost.Amount]', \
  '--output','table','--profile','paysense'])"
