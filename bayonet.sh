#!/bin/bash

#set -x
echo $PG_HOST:$PG_PORT:postgres:$PG_USER:$PG_PASSWD > ~/.pgpass
chmod 600 ~/.pgpass

# check pgsql start
while [ 1 ]; do
    psql -h $PG_HOST -U $PG_USER -tc "SELECT 1 FROM pg_database WHERE datname = '$PG_DB'" && break
    sleep 1
done

psql -h $PG_HOST -U $PG_USER -tc "SELECT 1 FROM pg_database WHERE datname = '$PG_DB'" | grep -q 1 || psql -h $PG_HOST -U $PG_USER -c "CREATE DATABASE $PG_DB"

chmod +x tools/scan/Chromium/crawlergo
chmod +x tools/scan/xray/xray
nohup python3 -u app.py > logs/web.log 2>&1 &
nohup python3 -u run_chromium.py > logs/chromium.log 2>&1 &
nohup python3 -u run_subdomain.py > logs/subdomain.log 2>&1 &
nohup python3 -u run_portscan.py > logs/portscan.log 2>&1 &
nohup python3 -u run_urlscan.py > logs/urlscan.log 2>&1 &
nohup python3 -u run_xray.py > logs/xray.log 2>&1 &

tail -f /dev/null