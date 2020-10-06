# VPC & EKS deployment using Terraform
## Description
The repository consists of two main directories:
#### 1. Terraform
This contains all the required terraform files to deploy a new VPC and a K8s (managed EKS) in AWS including:
* Private and Public subnets
* Internet Gateway
* NAT gateway
* Installing istio
* Create two namespaces (one for staging and on for the demo)

> The remote state is stored in S3 and locked using dynamoDB. </br>
 The bucket and the DynamoDB table need to be created before run the code.</br>
 You can use the code provided in Terraform/remote_state directory to create the bucket & the DynamoDB table



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
