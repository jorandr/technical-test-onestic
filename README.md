# Technical Test Onestic

## Table of Contents
- [Getting Started](#getting-started)
- [First Conclusions](#first-conclusions)
- [Onestic Technical Test Notes](#onestic-technical-test-notes)
  - [Terraform Installation](#terraform-installation)
  - [Networking Configuration (VPC, Subnet, Gateway)](#networking-configuration-vpc-subnet-gateway)
    - [Initial Configuration](#1-initial-configuration)
    - [Private IP Assignment](#2-private-ip-assignment)
    - [VPC, Subnet, and Gateway Configuration](#3-vpc-sub-ent-and-gateway-configuration)
    - [Security Configuration](#4-security-configuration)
  - [WordPress Container Configuration](#wordpress-container-configuration)
    - [Docker/Wordpress Issues](#1-dockerwordpress-issues)
  - [Load Balancer Configuration](#load-balancer-configuration)
    - [Load Balancer Selection](#1-load-balancer-selection)
    - [Manual Testing](#2-manual-testing)
    - [Container Configuration](#3-container-configuration)
    - [Nginx Logging Enablement](#4-nginx-logging-enablement)
    - [HAProxy Load Balancer Configuration](#5-haproxy-load-balancer-configuration)
- [Security Considerations](#security-considerations)
- [Connection Considerations](#connection-considerations)
- [Assistance from ChatGPT](#assistance-from-chatgpt)

## Getting Started

Before beginning with the implementation of the infrastructure, it's important to take some initial steps to understand the requirements and prepare the environment properly. Below are the ones that I've followed:

1. **Understand the Requirements:**
   - Carefully read the requirements provided in the technical test document.
   - Analyze the proposed architecture and understand each component and its function.

2. **Initial Research:**
   - Conduct initial research on the necessary technologies and tools for implementation, such as load balancers, web servers, and security practices.
   - Gather information on best practices for server configuration and cloud infrastructure management.

3. **Choose Tools and Platforms:**
   - Select the appropriate cloud platform for deploying the infrastructure, choosing between AWS or Google Platform.
   - Choose the tools and technologies that will be used for implementation, such as Terraform for resource provisioning, or Docker for virtualization.

4. **Prepare the Local Environment:**
   - Set up the local development environment with the necessary tools installed, and the client for the selected cloud platform.
   - Ensure access to the credentials for the cloud platform and the SSH keys required to access remote instances.

5. **Establish a Repository:**
   - Create a public repository on a platform like GitHub to store the code and documentation related to the technical test.
   - Initialize the repository with a `README.md` file to document the implementation process and the steps taken.

These initial steps will provide a solid base for beginning with the implementation of the infrastructure according to the established requirements. It's important to conduct thorough research and properly prepare the environment before proceeding with the configuration of resources in the cloud.

## First Conclusions

In this initial phase, several key decisions were made regarding the implementation of the infrastructure required. These decisions were based on consideration of the requirements, available technologies, and best practices. Below are the main conclusions and decisions reached:

1. **Technology Stack Selection:**
   - After evaluating various options, I have decided to leverage Docker for containerization. Docker provides lightweight and portable containers, making it easier to manage application dependencies and deployment across different environments.

2. **Cloud Platform Choice:**
   - Considering factors such as scalability, reliability, and ease of use, we have opted to utilize Amazon Web Services (AWS) as the cloud platform for hosting the infrastructure. AWS offers a wide range of services and features, including Elastic Compute Cloud (EC2) for virtual servers or Elastic Load Balancing (ELB) or Virtual Private Connections (VPC).

3. **Infrastructure as Code (IaC) Approach:**
   - To ensure consistency, repeatability, and scalability in the deployment process, I have chosen to implement Infrastructure as Code (IaC) principles. Terraform has been selected as the tool of choice for defining and provisioning the infrastructure resources in a declarative manner.

## Onestic Technical Test Notes

### Terraform Installation

Following the guide on [Adictos al Trabajo](https://www.adictosaltrabajo.com/2020/06/19/primeros-pasos-con-terraform-crear-instancia-ec2-en-aws/), Terraform installation was unsuccessful. Hence, the official documentation provided by [HashiCorp](https://developer.hashicorp.com/terraform/install?product_intent=terraform) was followed.

### Networking Configuration (VPC, Subnet, Gateway)

#### 1. Initial Configuration
   - An issue was encountered with the AWS region (not recognized).
   - Google and [Stack Overflow](https://stackoverflow.com/) were consulted to resolve it.

#### 2. Private IP Assignment
   - Difficulty arose in assigning private IPs to machines in the subnet.
   - Solutions were explored in the Terraform documentation: [Network Interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface). After discovering that using a network interface was unnecessary, a basic configuration with VPC, subnet, and gateway was attempted.

#### 3. VPC, Subnet, and Gateway Configuration
   - Essential configuration to resolve connectivity issues.
   - Documentation used: [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet), [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc), [Gateway](https://registry.terraform.io/providers/hashicorp/aws/3.14.1/docs/resources/internet_gateway), [Route table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association).

#### 4. Security Configuration
   - Rules were added to allow internal and external connectivity.
   - Documentation referenced: [Security Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group).

### WordPress Container Configuration

#### 1. Docker/Wordpress Issues
   - Manual installation of Docker and Wordpress was performed due to problems with the backslashes in the "run" command (which wasn't executing that part of the script). After successful manual configuration, the steps were simply placed in a script called in the "user_data" field of the instance.
   - Alternative guides consulted: [Arsys](https://www.arsys.es/blog/wordpress-contenedordocker) and [Taller de Docker](https://aulasoftwarelibre.github.io/taller-de-docker/wordpress/).
   - Successful configuration was verified by accessing the container from the network via the instance IP.

### Load Balancer Configuration

#### 1. Load Balancer Selection
   - Nginx was chosen as the load balancer.
   - Documentation consulted: [Nginx](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/) and [Docker](https://hub.docker.com/_/nginx).

#### 2. Manual Testing
   - Initial manual testing with Nginx before configuring with Terraform.

#### 3. Container Configuration
   - A tutorial on [YouTube](https://www.youtube.com/watch?v=_klWWkzfyes&ab_channel=HAH-Tech) was followed to isolate the configuration in a separate file (`Dockerfile` and `nginx.conf`, but eventually, due to issues and simplicity, the content was copied to the necessary file using the "echo" command.

#### 4. Nginx Logging Enablement
   - Nginx logs were enabled to diagnose redirection issues.
   - Configuration based on official documentation.
   - After successful configuration, it was observed that styles were not loaded upon redirection. Considering alternative solutions, a decision was made to configure a new load balancer with HAProxy, as the technology was already familiar.

#### 5. HAProxy Load Balancer Configuration
   - Official documentation for Docker HAProxy and HAProxy was consulted, and the instance was configured to automatically start with example configuration from the documentation adapted to the specific case.
   - After successful configuration of the load balancer, access to the Wordpress container through the balancer was verified, as well as direct access to the instance hosting Wordpress, confirming that direct access was not permitted, only through the balancer as per the documentation.
   - This final step is linked with the last step of the "Networking Configuration 4", concluding the security configuration.

## Security Considerations

Access to instances is done via SSH using a .pem key file, securely stored outside the repository for confidentiality. Similarly, AWS authentication keys necessary for access are managed within the terraform.tfvars file, which is not included in the repository for the same reason.

## Connection Considerations

The WordPress application can be accessed through the IP address 184.73.29.84 as specified in the requirements. Users can interact with the WordPress site using this IP address.

## Assistance from ChatGPT

Throughout the technical test, ChatGPT was used as a supportive tool to aid in various aspects of the process. It provided assistance in refining language, structuring documentation, resolving issues, and ensuring clarity and coherence in the implementation steps.


