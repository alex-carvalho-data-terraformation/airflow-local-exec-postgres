# <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> build

The build part trigger the construction of objects that consume a lot of time, like the `docker images`.  
It also creates objects that are desired to persist between executions, like `docker volumes`.

## 1. Configuration

1. Go to terraform config dir for build (from this README folder)
   
```bash
cd env/terraform/build/
```

2. Initialize Terraform

```bash
terraform init
```

## 2. Deployment instructions

Execute the build.  

```bash
terraform apply
```

## 3. How to run tests

### <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> 3.1. Check terraform objects

```bash
terraform state list
```

*Expected output similar to:*

```bash
docker_image.airflow_base
docker_image.airflow_local
docker_image.postgres
docker_volume.postgres_vol
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker images

```bash
docker image ls
```

*Expected output similar to:*

```bash
REPOSITORY    TAG               IMAGE ID       CREATED         SIZE
oak/airflow   2.2.2-local       f8111d64938b   5 minutes ago   1.13GB
oak/airflow   latest            f8111d64938b   5 minutes ago   1.13GB
oak/airflow   2.2.2-base        b872737d77f1   5 minutes ago   1.13GB
postgres      13.5              33f7fa4a9c0f   6 days ago      371MB
python        3.7-slim-buster   c2b8b72df8cd   7 days ago      113MB
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker volumes

```bash
docker volume ls
```

*Expected output similar to:*

```bash
DRIVER    VOLUME NAME
local     postgres-local-vol
```

## 4. Undeploy instructions

### 4.1. Stop and remove docker containers and volumes

at `local/terraform/build/`  

```bash
terraform destroy
```

### 4.2. Remove docker images

```bash
docker image rm oak/airflow:latest
docker image rm python:3.7-slim-buster
```
