# <img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;"> execution

It's intended to be very fast, less than 1 min.   
Here are created and `docker containers` and `docker networks` and destroyed after use.  

## 1. Configuration

1. Go to terraform config dir for execution (from this README folder)
   
```bash
cd env/terraform/exec/
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
docker_container.airflow_local
docker_container.postgres
docker_network.airflow_network
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.2. Check docker networks

```bash
docker network ls
```

*Expected output similar to:*

```bash
NETWORK ID     NAME              DRIVER    SCOPE
9e6ebdcbb222   airflow-network   bridge    local
```

### <img src="img/docker.png" alt="docker" height="20" style="vertical-align: middle;"> 3.3. Check docker containers

```bash
docker container ls
```

*Expected output similar to:*

```bash
CONTAINER ID   IMAGE                     COMMAND                  CREATED              STATUS                        PORTS                    NAMES
e8605652565d   oak/airflow:2.2.2-local   "./entrypoint.sh"        About a minute ago   Up About a minute (healthy)   0.0.0.0:8080->8080/tcp   airflow-local
4c7985595af7   postgres:13.5             "docker-entrypoint.s…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:5432->5432/tcp   postgres
```

## 4. URLs

#### airflow

[<img src="img/airflow.png" alt="Apache Airflow" height="60" style="vertical-align: middle;">](http://localhost:8080/)

http://localhost:8080/

|          |         |
|----------|---------|
| Username | airflow |
| Password | airflow |


## 5. Undeploy instructions

### 5.1. Stop and remove docker containers and volumes

at `env/terraform/exec/`  

```bash
terraform destroy
```
