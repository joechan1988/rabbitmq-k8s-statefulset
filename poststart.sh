#!/bin/bash
if [ -z "$(grep rabbitmq /etc/resolv.conf)" ]
then
    sed "s/^search \([^ ]\+\)/search rabbitmq.\1 \1/" /etc/resolv.conf > /etc/resolv.conf.new
    cat /etc/resolv.conf.new > /etc/resolv.conf
    rm /etc/resolv.conf.new
fi
until rabbitmqctl node_health_check; do sleep 1; done;
if [[ "$HOSTNAME" != "rabbitmq-0" && -z "$(rabbitmqctl cluster_status | grep rabbitmq-0)" ]]
then
  rabbitmqctl stop_app
  rabbitmqctl join_cluster rabbit@rabbitmq-0
  rabbitmqctl start_app
fi
rabbitmqctl set_policy ha-all "." '{"ha-mode":"all","ha-sync-mode":"automatic"}'
