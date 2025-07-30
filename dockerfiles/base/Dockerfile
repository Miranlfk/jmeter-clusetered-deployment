FROM openjdk:11-jre-slim

ENV JMETER_VERSION=5.6.3
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV PATH=$JMETER_HOME/bin:$PATH

RUN apt-get update && \
    apt-get install -y wget unzip ca-certificates && \
    wget https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz -q && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm apache-jmeter-${JMETER_VERSION}.tgz && \
    wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/1.8/jmeter-plugins-manager-1.8.jar -q -O $JMETER_HOME/lib/ext/jmeter-plugins-manager.jar && \
    wget https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.3/cmdrunner-2.3.jar -q -O $JMETER_HOME/lib/cmdrunner-2.3.jar && \
    wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-tst/2.6/jmeter-plugins-tst-2.6.jar -O $JMETER_HOME/lib/ext/jmeter-plugins-tst-2.6.jar && \
    wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-casutg/2.10/jmeter-plugins-casutg-2.10.jar -O $JMETER_HOME/lib/ext/jmeter-plugins-casutg-2.10.jar && \
    apt-get remove --purge -y wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $JMETER_HOME

CMD ["jmeter"]
