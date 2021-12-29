terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {}

######################################################
# NETWORK
######################################################

resource "docker_network" "airflow_network" {
  name = "airflow-network"
}

######################################################
# DATABASE SERVICE
######################################################

resource "docker_container" "postgres" {
  image   = "postgres:13.5"
  name    = "postgres"
  restart = "always"

  ports {
    external = 5432
    internal = 5432
  }

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  env = [
    "POSTGRES_DB=airflow_db",
    "POSTGRES_USER=airflow",
    "POSTGRES_PASSWORD=airflow"
  ]

  volumes {
    volume_name    = "postgres-local-vol"
    container_path = "/var/lib/postgresql/data"
  }

  healthcheck {
    test = ["CMD", "pg_isready", "-q", "-d", "airflow_db", "-U", "airflow"]
  }
}

######################################################
# AIRFLOW
######################################################

resource "docker_container" "airflow_local" {
  image      = "oak/airflow:2.2.2-local"
  name       = "airflow-local"
  restart    = "always"
  depends_on = [docker_container.postgres]

  ports {
    external = 8080
    internal = 8080
  }

  networks_advanced {
    name = docker_network.airflow_network.name
  }

  env = [
    "AIRFLOW_DAG_SAMPLES=N",
    "POSTGRES_HOST=postgres"
  ]

  volumes {
    host_path      = "${path.cwd}/../../../mnt/airflow/dags/"
    container_path = "/opt/airflow/dags/"
  }

  healthcheck {
    test = ["CMD", "nc", "-z", "airflow-local", "8080"]
  }
}