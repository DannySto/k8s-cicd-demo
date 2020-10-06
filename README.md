# VPC & EKS deployment using Terraform
## Description
The repository consists of two main directories:
- Terraform 
- Manifests

**Terraform:** 
This Contains all the required terraform files to deploy a new VPC in AWS including:
* Private and Public subnets
* Internet Gateway
* NAT gateway
* S3 buckets (will be used to store the terraform remote state)
* dynamoDB (will be used for state locking )


**Manifests:**
This contains all the required yaml files to deploy in the k8s:
* 
## Architecture 

![aws](https://github.com/lefterisALEX/k8s-cicd-demo/blob/master/.images/aws-architecture.png?raw=true)

## K8S

![aws](https://github.com/lefterisALEX/k8s-cicd-demo/blob/master/.images/k8s-svc.png?raw=true)


## Architecture 

![aws](https://github.com/lefterisALEX/k8s-cicd-demo/blob/master/.images/aws-architecture.png?raw=true)

## K8S

![aws](https://github.com/lefterisALEX/k8s-cicd-demo/blob/master/.images/k8s-svc.png?raw=true)