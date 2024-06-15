# MultiCloudDevOpsProject
**Welcome to the MultiCloudDevOpsProject repository!**


![alt text](<Terraform/Screenshots/Untitled Diagram.drawio-7.svg>)
## Overview
This project is designed to demonstrate a full DevOps pipeline with complete CI/CD pipeline setup for a Java application using Terraform, Ansible, Jenkins, SonarQube, and OpenShift. The pipeline begins with infrastructure provisioning on AWS using Terraform, followed by configuration management and application deployment using Ansible, Jenkins, SonarQube and Deploy on OpenShift Cluster.


## Rebosatory structure

```
├── Terraform
│   ├── outputs.tf
│   ├── variables.tf
│   ├── main.tf
│   ├── modules
│   │   ├── instance
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   └── variables.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── output.tf
│   │       └── variables.tf
│   └── Screenshots
├── ansible
│   ├── ansible.cfg
│   ├── aws_ec2.yml
│   ├── playbook.yml
│   └── roles
│       ├── docker
│       │   ├── tasks
│       │   │   └── main.yml
│       ├── jenkins
│       │   ├── tasks
│       │   │   └── main.yml
│       ├── oc_cli
│       │   └── tasks
│       │       └── main.yml
│       └── sonarqube
│           └── tasks
│               └── main.yml
├── Application
├── Jenkinsfile
├── oc
│   ├── deployment.yml
│   ├── route.yml
│   └── service.yml
├── shared_library
│   └── vars
│       ├── buildAndPushDockerImage.groovy
│       ├── build.groovy
│       ├── deployOnOc.groovy
│       ├── editNewImage.groovy
│       ├── runUnitTests.groovy
│       └── sonarQubeAnalysis.groovy
└── README.md

```

## Table of Contents
- Project Setup
- Infrastructure Provisioning
- Configuration Management
- Containerization
- Continuous Integration
- Automated Deployment Pipeline
- Monitoring and Logging
- AWS Integration
- Documentation

## Prerequisites
Before using this project, ensure that you have the following prerequisites:

- Docker: For building and managing containerized applications.
- Kubernetes/OpenShift: For orchestrating containerized applications.
- Jenkins: For implementing continuous integration and continuous deployment (CI/CD) pipelines.
- Docker Hub Account: For storing Docker images.
- Git: For version control and cloning the project repository.

## Repository Setup
### Initial Configuration
- Create and Clone the Repository:

A new repository named "MultiCloudDevOpsProject" was created.
Clone this repository to get started:
```bash
git clone https://github.com/jowe2114/MultiCloudDevOpsProject.git
```
- Branching:
    - Main branch
    - Dev branch
    
#### Branch Creation:

Create a development branch named dev.
Instructions:
```bash
git checkout -b dev
git push origin dev
```

#### And this the output in github website 

![alt text](<Terraform/Screenshots/Screenshot 2024-06-15 at 17.09.01.png>)

## Infrastructure Provisioning with Terraform
### Task: 
- Provision AWS resources including VPC, subnets, security groups, and EC2 instances.
### Steps:
- Write Terraform modules for each resource.
- Use the modules to create the infrastructure.
- Commit the Terraform scripts to the dev branch.
- save the state in remote backend state ( S3 with DynamoDB)

### Terraform Setup


the goal of this task is to provision AWS infrastructure using Terraform scripts. Specifically, the task involves provisioning the following resources:

- Virtual Private Cloud (VPC)
- Subnets
- Security Groups
- EC2 instances for deploying applications

### Deliverables:

1. **Terraform Scripts**: 
   - The Terraform scripts should be developed and committed to the repository provided.
   - These scripts will define the infrastructure as code, enabling reproducible and version-controlled infrastructure provisioning.

2. **Use of Terraform Modules**:
   - Modularization of Terraform code is encouraged to promote reusability, maintainability, and readability.
   - Utilize Terraform modules for managing different components of the infrastructure, such as VPC, Subnets, Security Groups, and EC2 instances.

```
project-root/
│
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ ├── modules/
│ │ ├── vpc/
│ │ │    ├── main.tf
│ │ │    ├── variables.tf
│ │ │    └── outputs.tf
│ │ └── instances/
│ │      ├── main.tf
│ │      ├── variables.tf
│ │      └── outputs.tf
│ └── terraform.tfvars
└── README.md
```

### Getting Started:

```bash
   terraform init
```
![alt text](<Terraform/Screenshots/Screenshot 2024-06-14 at 14.58.12.png>)


##### S3 and DynamoDB

![alt text](<Terraform/Screenshots/Screenshot 2024-06-13 at 12.55.13.png>) 
![alt text](<Terraform/Screenshots/Screenshot 2024-06-13 at 12.55.40.png>)


1. **Navigate to the Terraform Directory**:
```bash
   cd terraform
```
2. **Initialize Terraform**:
```bash
  terraform init
```
3. **Provide AWS Credentials**:

Ensure that AWS credentials are configured either through environment variables or AWS shared credentials file.

4. **Apply Infrastructure Changes**:

```bash
terraform apply -auto-approve
```
![alt text](<Terraform/Screenshots/Screenshot 2024-06-14 at 15.05.33.png>)

5. **the EC2-Running in AWS Console with same IP**

![alt text](<Terraform/Screenshots/Screenshot 2024-06-14 at 15.05.58.png>)

## EC2 Monitoring and Notification Setup using Terraform

create an SNS to handle notifications.
create a subscription to the SNS topic that will send notifications to your email address.
 ![alt text](<Terraform/Screenshots/Screenshot 2024-06-15 at 17.33.30.png>) 


after we getting the ip from terraform we will pass it to Ansible inventory to run playbook on it 

## Configuration Management with Ansible

### Task Description:

The objective of this task is to configure EC2 instances using Ansible playbooks. The playbooks should automate the following tasks:

- Installation of required packages such as Git, Docker, and Java.
- Installation of required packages for Jenkins and SonarQube.
- Setup of necessary environment variables.


### Deliverables:

1. **Ansible Playbooks**:
   - Develop Ansible playbooks to automate the configuration tasks mentioned above.
   - The playbooks should be committed to the repository provided.

2. **Use of Ansible Roles**:
   - Organize the Ansible playbooks using roles to promote modularity, reusability, and maintainability.
   - Utilize roles to encapsulate the configuration tasks for Git, Docker, Java, Jenkins, and SonarQube.


### Getting Started:

**Check the Graph**
```bash

ansible-inventory --graph
```
![alt text](<ansible/Screenshots/Screenshot 2024-06-15 at 12.36.54.png>)
![alt text](<ansible/Screenshots/Screenshot 2024-06-14 at 15.09.34.png>)

**Create Directory Structure for the Role**

Role Directory:
    Create the role directory structure using the following command for each role
```bash
ansible-playbook -i aws_ec2.yml dokk.yaml --private-key -/dbserver.pem -u ubuntu
ansible-playbook -i aws_ec2.yml jenn.yaml --private-key -/dbserver.pem -u ubuntu
ansible-playbook -i aws_ec2.yml oc.yaml --private-key -/dbserver.pem -u ubuntu
ansible-playbook -i aws_ec2.yml sonn.yaml --private-key -/dbserver.pem -u ubuntu
```
![alt text](<ansible/Screenshots/Screenshot 2024-06-13 at 17.10.43.png>)
![alt text](<ansible/Screenshots/Screenshot 2024-06-14 at 15.21.42.png>)
![alt text](<ansible/Screenshots/Screenshot 2024-06-14 at 15.23.34.png>)
![alt text](<ansible/Screenshots/Screenshot 2024-06-14 at 15.37.57.png>)




4. **Execute Playbook**:

Execute the playbook using the following command, specifying your inventory (jenkins-server) in the file install_jenkins.yml , (docker-server) in the file install_docker.yml ,(sonarQube-server) in the file sonarQube.yml 


the command to run playbook for each group server 
```bash
ansible-playbook -i inventory playbook.yml

```
![alt text](<screenshots/task3 ansible/3jenkiins_role.png>)

#### Edit a new task to show the intial password for jenkins

![alt text](<ansible/Screenshots/Screenshot 2024-06-14 at 15.42.51.png>)

```bash

ansible-playbook -i inventory install_docker.yml
```

#### the website for sonar 
![alt text](<SonarQube/Screenshots/Screenshot 2024-06-14 at 16.05.21.png>)

#### the website for Jenkins 
![alt text](<Jenkins/Screenshots/Screenshot 2024-06-14 at 15.56.33.png>)


## Continuous Integration with Jenkins


The objective of this task is to set up Continuous Integration (CI) with Jenkins to automate the building of Docker images upon code commits. Jenkins will be configured to monitor the repository for changes and trigger a build process whenever new code is committed.
### SSH Key Generation for Slave Instance
To securely connect your Jenkins master to the slave instance, you need to generate an SSH key pair and configure the private key on the Jenkins master.

1. Add Credentials to Jenkins

- Navigate to Jenkins web UI.
- Go to Manage Jenkins > Manage Credentials > (global) > Add Credentials.

![alt text](<Jenkins/Screenshots/Screenshot 2024-06-15 at 12.53.03.png>)

```groovy
// jenkinsfile for this project is like this 
@Library('Jowe-shared-library')_
pipeline {
    agent any

    environment {
        dockerHubCredentialsID    = 'DockerHub'
        imageName                 = 'jowe2114/java-app'
        openshiftCredentialsID    = 'openshift'
        nameSpace                 = 'omaryousef'
        clusterUrl                = 'https://api.ocp-training.ivolve-test.com:6443'
        gitRepoName               = 'MultiCloudDevOpsProject'
        gitUserName               = 'jowe2114'
        gitUserEmail              = 'omaryoussef19999@gmail.com'
        githubToken               = 'github-token'
        sonarqubeUrl              = 'http://54.147.42.207:9000/'
        sonarTokenCredentialsID   = 'sonar-token'
        k8sCredentialsID          = 'Kubernetes'
        yamlfiles                 = 'oc/deployment.yml'
        REGISTRY                  = 'docker.io'
        SERVICE_NAME              = 'java-app'
    }

    stages {       
        stage('Build') {
            steps {
                script {
                    dir('Application') {
                        build()
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    dir('Application') {
                        sonarQubeAnalysis()
                    }
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: "${dockerHubCredentialsID}", variable: 'DOCKERHUB_TOKEN')]) {
                        sh "echo \$DOCKERHUB_TOKEN | docker login -u jowe2114 --password-stdin"
                        sh "docker info"
                        sh "docker build -t ${imageName} ./Application"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }

        
        stage('Deploy to OpenShift') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'OPEN_SHIFT_TOKEN_LOGIN', variable: 'OPEN_SHIFT_TOKEN')]) {
                        sh "oc login --token=\${OPEN_SHIFT_TOKEN} --server=${clusterUrl} --insecure-skip-tls-verify"
                        sh "oc new-app \${REGISTRY}/${imageName}"
                        sh "oc expose service/${SERVICE_NAME}"
                        sh "oc get route"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
}

```

 
### SonarQube Analysis

![alt text](<SonarQube/Screenshots/Screenshot 2024-06-14 at 19.00.25.png>)

![alt text](<SonarQube/Screenshots/Screenshot 2024-06-14 at 22.03.56.png>)
- Step 6: Build and Push Docker Image
    - This step builds the Docker image for the application and pushes it to Docker Hub using custom shared library steps.
    - tages is number of build jenkinsfile 

    ![alt text](<SonarQube/Screenshots/Screenshot 2024-06-14 at 19.50.13.png>)
    in this stage we using Shared library for 
    #### Jenkins Shared Libraries
To manage reusable pipeline code, you can use Jenkins shared libraries. Create the following Groovy scripts in your shared library repository:

#### Shared Library Repository
You can find a custom shared library at the following URL:
 ![alt text](<Jenkins/Screenshots/Screenshot 2024-06-14 at 16.16.49.png>)


### Finally, the Pipeline Succeeded
After several iterations and troubleshooting, we achieved a successful pipeline execution. This was a significant milestone in our project.

![alt text](<Jenkins/Screenshots/Screenshot 2024-06-15 at 13.14.36.png>)
![alt text](<Jenkins/Screenshots/Screenshot 2024-06-14 at 22.03.25.png>)


## Verify that works in OPENSHIFT cluster

 ```bash
# show 
 oc get deployments
 oc get service
 oc get routes
 curl java-app-omaryousef.apps.ocp-training.ivolve-test.com 
```

### Additional Resources

| Resource                         | Link                                                                                       |
|----------------------------------|--------------------------------------------------------------------------------------------|
| Ansible Documentation            | [Ansible Documentation](https://docs.ansible.com/)                                             |
| Jenkins Documentation            | [Jenkins Documentation](https://www.jenkins.io/doc/)                                       |
| Docker Documentation             | [Docker Documentation](https://docs.docker.com/)                                           |
| Terraform Documentation          | [Terraform Documentation](https://www.terraform.io/docs/index.html)                        |
| SonarQube Documentation          | [SonarQube Documentation](https://docs.sonarqube.org/latest/)                               |
| OpenShift CLI Documentation      | [OpenShift CLI Documentation](https://docs.openshift.com/container-platform/latest/cli_reference/openshift_cli/getting-started-cli.html) |
| AWS EC2 Documentation            | [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)                        |


