# technical-test-onestic
This is a technical test for a devops-sysadmin role at Onestic done by Jorge Andrés Nieto
## Getting Started

Before beginning with the implementation of the infrastructure, it's important to take some initial steps to understand the requirements and prepare the environment properly. Below are the ones that i've followed:

1. **Understand the Requirements:**
   - Carefully read the requirements provided in the technical test document.
   - Analyze the proposed architecture and understand each component and its function.

2. **Initial Research:**
   - Conduct initial research on the necessary technologies and tools for implementation, such as load balancers, web servers, and security practices.
   - Gather information on best practices for server configuration and cloud infrastructure management.

3. **Choose Tools and Platforms:**
   - Select the appropriate cloud platform for deploying the infrastructure, choosing between AWS or Google Platform.
   - Choose the tools and technologies that will be used for implementation, such as Terraform for resource provisioning, or docker for virtualization.

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
   - After evaluating various options, i have decided to leverage Docker for containerization. Docker provides lightweight and portable containers, making it easier to manage application dependencies and deployment across different environments.

2. **Cloud Platform Choice:**
   - Considering factors such as scalability, reliability, and ease of use, we have opted to utilize Amazon Web Services (AWS) as the cloud platform for hosting the infrastructure. AWS offers a wide range of services and features, including Elastic Compute Cloud (EC2) for virtual servers or Elastic Load Balancing (ELB) or Virtual Private Connections (VPC), that will be a good option for the future.

3. **Infrastructure as Code (IaC) Approach:**
   - To ensure consistency, repeatability, and scalability in the deployment process,i have chosen to implement Infrastructure as Code (IaC) principles. Terraform has been selected as the tool of choice for defining and provisioning the infrastructure resources in a declarative manner.


