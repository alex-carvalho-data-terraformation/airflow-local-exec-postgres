# BUILD (manual): docker image build --rm -t oak/airflow:2.2.2-local .

FROM oak/airflow:2.2.2-base

LABEL com.oak.docker.image.tag="1.0.0-local"

WORKDIR ${AIRFLOW_HOME}

COPY script/entrypoint.sh .

RUN chmod o+x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8080
