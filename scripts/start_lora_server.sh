#!/bin/bash

set -x

# terminate all previous running instances
kill -9 `ps ax | grep loraserver -m 1 | awk '{print $1}'`

# source the environment parameters
. /etc/lora/networkserver.env

# launch the app
loraserver --net-id "$NET_ID" --band "$BAND" --redis-url "$REDIS_URL" --postgres-dsn "$POSTGRES_DSN" --controller-mqtt-server "$CONTROLLER_MQTT_SERVER" --gw-mqtt-server "$GW_MQTT_SERVER" --app-mqtt-server "$APP_MQTT_SERVER"  --db-automigrate "$DB_AUTOMIGRATE" >> /var/log/lora-network-server/lora-network-server.log 2>&1 &
