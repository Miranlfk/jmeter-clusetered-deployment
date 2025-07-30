FROM 302263080987.dkr.ecr.us-east-2.amazonaws.com/jmeter:5.6.3

EXPOSE 60000
ENV SSL_DISABLED=true
ENV ONE_SHOT=true
ENV SLAVE_SVC_NAME=jmeter-slave
ENV TESTS_DIR=/test

ADD run-test.sh /run-test.sh
RUN chmod +x /run-test.sh \
    && mkdir /test

ENTRYPOINT /run-test.sh