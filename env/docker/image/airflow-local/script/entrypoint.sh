#!/bin/bash

: ${POSTGRES_HOST:=postgres}
: ${POSTGRES_PORT:=5432}
: ${POSTGRES_DB:=airflow_db}
: ${POSTGRES_USER:=airflow}
: ${POSTGRES_PASSWORD:=airflow}

: ${AIRFLOW_DAG_SAMPLES:=N}

wait_for_service_startup() {
  local service_name="$1" service_host=$2 service_port=$3
  local service_dep_ok=1
  for i in {1..25}
  do
    nc -z "$service_host" "$service_port"
    if [ $? -eq 0 ]; then
      service_dep_ok=0
      break
    fi
    echo "$service_name connection $i of 25 attempt has failed ($POSTGRES_HOST:$POSTGRES_PORT)"
    sleep 5
  done
  if [ ! $service_dep_ok -eq 0 ]; then
    echo "$service_name not reachable after 25"
    exit 1
  fi
}


wait_for_service_startup "postgres" $POSTGRES_HOST $POSTGRES_PORT

if [ AIRFLOW_DAG_SAMPLES == Y ]; then
  AIRFLOW__CORE__LOAD_EXAMPLES=True
else
  AIRFLOW__CORE__LOAD_EXAMPLES=False
fi

postgres_conn_str="$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB"

AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://$postgres_conn_str"
AIRFLOW__CELERY__RESULT_BACKEND="db+postgresql://$postgres_conn_str"
AIRFLOW__WEBSERVER__EXPOSE_CONFIG="True"
AIRFLOW__CORE__EXECUTOR="LocalExecutor"

export AIRFLOW__CORE__LOAD_EXAMPLES \
       AIRFLOW__CORE__SQL_ALCHEMY_CONN \
       AIRFLOW__CELERY__RESULT_BACKEND \
       AIRFLOW__WEBSERVER__EXPOSE_CONFIG \
       AIRFLOW__CORE__EXECUTOR

airflow db init
airflow users create -e "admin@airflow.com" -f "airflow" -l "airflow" -p "airflow" -r "Admin" -u "airflow"
airflow scheduler &
airflow webserver
