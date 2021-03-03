#FROM gradle:6.5.1 as builder
#COPY . .
#RUN gradle shadowJar

FROM flink:scala_2.11-java11
COPY files $FLINK_HOME/files/
RUN rm $FLINK_HOME/lib/*; \
    cp -fr  $FLINK_HOME/files/. $FLINK_HOME ; \
    echo "metrics.reporters: prom" >> "$FLINK_HOME/conf/flink-conf.yaml"; \
    echo "metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter" >> "$FLINK_HOME/conf/flink-conf.yaml"; \
    echo "web.submit.enable: true">> "$FLINK_HOME/conf/flink-conf.yaml";\
    echo "taskmanager.memory.process.size: 3528m" >> "$FLINK_HOME/conf/flink-conf.yaml";\
    echo "jobmanager.memory.process.size: 3500m">>"$FLINK_HOME/conf/flink-conf.yaml";

COPY *.jar $FLINK_HOME/lib/
#COPY --from=builder /home/gradle/build/libs/*.jar $FLINK_HOME/lib/
