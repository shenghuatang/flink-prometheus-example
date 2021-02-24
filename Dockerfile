FROM gradle:6.5.1 as builder
COPY . .
RUN gradle shadowJar

FROM flink:1.11.1
COPY *.jar $FLINK_HOME/lib/
RUN echo "metrics.reporters: prom" >> "$FLINK_HOME/conf/flink-conf.yaml"; \
    echo "metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter" >> "$FLINK_HOME/conf/flink-conf.yaml"; 
COPY --from=builder /home/gradle/build/libs/*.jar $FLINK_HOME/lib/
