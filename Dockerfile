#FROM gradle:6.5.1 as builder
#COPY . .
#RUN gradle shadowJar

FROM flink:scala_2.11-java11
COPY 2.13  $FLINK_HOME/files/
COPY *.jar $FLINK_HOME/files/lib/
RUN rm $FLINK_HOME/lib/*; \
    cp -fr $FLINK_HOME/files/. $FLINK_HOME/; \
    echo "metrics.reporters: prom" >> "$FLINK_HOME/conf/flink-conf.yaml"; \
    echo "metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter" >> "$FLINK_HOME/conf/flink-conf.yaml"; 
#COPY --from=builder /home/gradle/build/libs/*.jar $FLINK_HOME/lib/
