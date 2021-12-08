FROM hub.lalonsec.com/lalon_base/ubuntu:20.04

RUN apt update && apt upgrade -y && \
    apt install -y chromium-browser python3 python3-dev python3-pip python3-openssl python3-ldap nmap python3-psycopg2 postgresql-client

ENV BAYONET_HOME=/bayonet
WORKDIR $BAYONET_HOME

COPY requirements.txt $BAYONET_HOME/requirements.txt

RUN  pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple

COPY ./  $BAYONET_HOME

RUN chmod +x ./bayonet.sh

EXPOSE 80

CMD ./bayonet.sh
