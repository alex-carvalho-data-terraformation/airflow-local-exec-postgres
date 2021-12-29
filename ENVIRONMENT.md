# environment #

## Quick summary  

<img src="img/terraform.png" alt="Terraform" height="30" style="vertical-align: middle;"> Terraform infrastructure containing: 

### network

- 1 network called `airflow-celery-net`

### containers <img src="img/docker.png" alt="docker" height="30" style="vertical-align: middle;">

- 1 <img src="img/postgresql.png" alt="PostgreSQL" height="20" style="vertical-align: middle;"> [PostgreSQL](#postgresql)
- 1 <img src="img/airflow.png" alt="Apache Airflow" height="20" style="vertical-align: middle;"> [airflow](#airflow)


# container descriptions #

## PostgreSQL

<img src="img/postgresql.png" alt="PostgreSQL" height="60" style="vertical-align: middle;">

### software

- PostgreSQL 13.5
- debian 11 (bullseye)

### exposed ports (host:container)

- 5432:5432

### container specific info

#### database
| database name | user    | password |
|---------------|---------|----------|
| airflow_db    | airflow | airflow  |

## airflow

<img src="img/airflow.png" alt="Apache Airflow" height="60" style="vertical-align: middle;">

### software

- airflow 2.2.2
  - extras
    - celery
    - postgres
    - apache.hive
    - jdbc
    - mysql
    - ssh
    - redis
- python 3.7
- pip 21.2.4
- git 2.20.1
- netcat
- debian 10 (buster)

### exposed ports (host:container)

- 8080:8080

### container specific info

#### URL

http://localhost:8080/

|              |         |
|--------------|---------|
| **Username** | airflow |
| **Password** | airflow |

#### Local dags directory

The `DAG`s directory is mounted outside the container.  

`DAG` directory mount location:

```bash
[git repo root]/mnt/airflow/dags
```

Any `DAG` placed at this directory will be visible at visible inside the container.  


