#!/bin/bash

# terminate all previous running instances
kill -9 `ps ax | grep loraserver -m 1 | awk '{print $1}'`

# source the environment parameters
. /etc/lora/networkserver.env

# launch the app
loraserver --net-id $NET_ID --band $BAND --postgres-dsn $POSTGRES_DSN --gw-mqtt-server $GW_MQTT_SERVER --app-mqtt-server $APP_MQTT_SERVER  --db-automigrate $DB_AUTOMIGRATE --redis-url $REDIS_URL >> /var/log/lora-network-server/lora-network-server.log 2>&1 &
