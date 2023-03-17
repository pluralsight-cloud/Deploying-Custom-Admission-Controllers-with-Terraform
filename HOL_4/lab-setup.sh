#!/usr/bin/env bash

### Deploy the EKS Cluster with Terraform ###
cd eks
terraform init
terraform apply -auto-approve

### Configure AWS CLI ###
echo "User Name,Access key id,Secret access key" > credentials.csv
echo "default,$(terraform output -raw AccessKey),$(terraform output -raw SecretKey)" >> credentials.csv
aws configure import --csv file://credentials.csv
#rm -rf credentials.csv

### Configuring kubectl ###
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

### Cluster Up and Ready ###
echo "EKS Cluster $(terraform output -raw cluster_name) Up and Ready in Region $(terraform output -raw region)"