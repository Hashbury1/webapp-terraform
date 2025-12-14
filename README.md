This repository contains the Terraform configuration files required to provision a highly available, 
scalable Travel Web Application infrastructure on Amazon Web Services (AWS).

The entire environment, including the virtual servers (EC2) and the load balancer (ELB), is defined and deployed using Infrastructure-as-Code (IaC).⚙️ 

The infrastructure is designed for fault tolerance and scalability across multiple Availability Zones (AZs) in a single region.VPC: 

A dedicated Virtual Private Cloud (VPC) with public and private subnets across two Availability Zones.EC2: Two identical application servers running the Travel Web App, automatically provisioned into the private subnets.ELB: An Application Load Balancer (ALB) distributes incoming user traffic across the EC2 instances.

Auto Scaling: An Auto Scaling Group (ASG) ensures that two healthy instances are always running.Security: Separate Security Groups (SGs) control traffic flow between the ALBs, EC2s, and the internet.

Prerequisites

Before running the Terraform code, ensure you have the following installed and configured:

Terraform: Install the latest version of Terraform.

AWS CLI: Configure the AWS Command Line Interface with appropriate credentials. 

Terraform uses these credentials to provision resources.Bashaws configure
SSH Key Pair: You must have an existing SSH Key Pair in your AWS region named travel-app-key. This key is used to connect to the EC2 instances.🛠️ 


Deployment StepsFollow these steps to deploy the entire infrastructure in under 5 minutes.

1. Initialize TerraformNavigate to the project root directory and initialize the backend and modules.Bashterraform init

2. Review the PlanGenerate an execution plan to see exactly which resources Terraform will create. Always review this output to prevent unexpected billing.Bashterraform plan

3. Apply the ConfigurationExecute the plan and provision the infrastructure on AWS. Type yes when prompted.Bashterraform apply

4. Verify and Access the ApplicationOnce the terraform apply command completes successfully, the public DNS name of your Application Load Balancer (ALB) will be displayed in the output.Look for the alb_dns_name output variable.BashOutputs:

alb_dns_name = "http://travel-app-alb-xxxx.us-east-1.elb.amazonaws.com"
Access the App: Paste the alb_dns_name into your web browser to access the Travel Web Application. 

Repository StructureThe code is organized to follow standard Terraform best practices:File/DirectoryPurposemain.tf

Defines the core AWS resources: VPC, Subnets, and Security Groups.ec2.tfConfigures the EC2 instances, Launch Template, and Auto Scaling Group.elb.tf

Defines the Application Load Balancer (ALB), Target Group, and Listeners.outputs.tf

Defines the output variables, primarily the ALB DNS name.variables.tf

Contains all customizable variables (region, key name, instance type, etc.).userdata.shBash script executed on EC2 instance boot to install necessary dependencies (Node.js, Nginx, or Docker) and start the web app.🗑️ Cleanup and DestructionWhen you are finished testing the environment, use the following command to safely tear down all resources provisioned by Terraform.


WARNING: This action is irreversible and will destroy all infrastructure, including the EC2 instances and the application data.Bashterraform destroy
Type yes when prompted to confirm the destruction.

