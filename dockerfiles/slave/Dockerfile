FROM 302263080987.dkr.ecr.us-east-2.amazonaws.com/jmeter:5.6.3

EXPOSE 1099 60001
ENV SSL_DISABLED=true

ENTRYPOINT jmeter-server -Dserver.rmi.localport=60001 -Dserver_port=1099 \
            -Jserver.rmi.ssl.disable=${SSL_DISABLED}



