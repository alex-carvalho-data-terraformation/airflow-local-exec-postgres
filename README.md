# <img src="img/terraform.png" alt="terraform" width="30" style="vertical-align: middle;"> | airflow with local executor and PostgreSQL backend db | infra #

## <img src="img/terraform.png" alt="HashiCorp Terraform" height="100" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="100" style="vertical-align: middle;"> <img src="img/postgresql.png" alt="PostgreSQL" height="100" style="vertical-align: middle;"> <img src="img/airflow.png" alt="Apache Airflow" height="100" style="vertical-align: middle;">  

## What is this repository for? ##

### Quick summary

This project is intended to demosntrate a `Terraform` infrastruture as code for `Apache Airflow` with a `Local Executor` and `PostgreSQL` backend on `Docker` containers. 

[Environment description](ENVIRONMENT.md)

## How do I get set up? ##

### 1. Summary of set up

All environment is built using Terraform.  

Basically it's necessary to initialize the Terraform environment.  

The infrastructure is split into 2 parts:

- [build](BUILD.md)
- [execution](EXEC.md)

#### 1.1. build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.  

[build instructions](BUILD.md)

#### 1.2. execution

It's intended to be very fast, less than 3 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

[execution instructions](EXEC.md)

### 2. Dependencies

- <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> [install docker](https://docs.docker.com/get-docker/)
- <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> [install terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Who do I talk to? ##

### Repo owner 

alex.carvalho.data@gmail.com
