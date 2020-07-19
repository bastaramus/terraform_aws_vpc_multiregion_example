Infrastructure as a service code. To get started with it, there are multiple steps, including installing Terraform and the AWS provider. 

## Software requirements
Terraform 0.12
AWS CLI

## Big Bang Step

*In this, and all future steps, $ROOT is the root of the git repo.*
You shouldn't run this step if you are not sure. There is a terraform.tfstate file in the source control, you can delete it if wou want 
to start from the begining.

```cd $ROOT/infrastructure/init``` 
```terraform init``` 
```terraform apply``` 

This will create the lock table in DynamoDB and the S3 bucket for storing the current Terraform state for all other modules. In all other directories listed below, you will need to do, at a minimum terraform init to get your working directory synced with the live state.

## Source Layout

**environments:** folder to isolate various environment (development/test/stage/production) specific configuration.
**modules:** folder to host reusable resource sets (modules)
**init:** folder with sources for Big Bang Step

Region specific configurations are managed through their respective <workspace>.tfvars file. For example, environments/development/eu-central-1.tfvars file for eu-central-1 region in development environment.

Also, terraform.tfvars file found inside development/test/stage/production folder under environments could be used to set common configuration for a given environment, across all regions.

## Working with the setup

aws-profile.sh sets up your AWS profile in your environment. If you have multiple profiles in your AWS config, you can use it with 

 ```./aws-profile.sh profile_name```

Navigate to the environment folder, development for example, on the terminal.

**Initialize terraform**

To get started, first initialize your local terraform state information

```terraform init```

**List out the available workspaces**

```terraform workspace list```

**Create a new workspace (if it doesn't exist already)**

```terraform workspace new ap-southeast-2```

**Select a workspace**

```terraform workspace select ap-southeast-2```

**Plan & apply changes**

```terraform plan -var-file ap-southeast-2.tfvars -var-file terraform.tfvar```
```terraform apply -var-file ap-southeast-2.tfvars -var-file terraform.tfvar```

**Repeat for other regions**

For ap-southeast-1 region:
```terraform workspace new ap-southeast-1```
```terraform workspace select ap-southeast-1```
```terraform plan -var-file=ap-southeast-1.tfvars -var-file terraform.tfvar```
```terraform apply -var-file=ap-southeast-1.tfvars -var-file terraform.tfvar```