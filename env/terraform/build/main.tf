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
# DATABASE SERVICE
######################################################

resource "docker_image" "postgres" {
  name = "postgres:13.5"
}

######################################################
# AIRFLOW
######################################################

resource "docker_image" "airflow_base" {
  name = "oak/airflow:2.2.2-base"

  build {
    path = "../../docker/image/airflow-base/"
    tag  = ["oak/airflow:latest"]
  }
}

resource "docker_image" "airflow_local" {
  name       = "oak/airflow:2.2.2-local"
  depends_on = [docker_image.airflow_base]

  build {
    path = "../../docker/image/airflow-local/"
    tag  = ["oak/airflow:latest"]
  }
}