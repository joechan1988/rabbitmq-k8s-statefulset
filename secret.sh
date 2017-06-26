#!/bin/bash
kubectl create secret generic rabbitmq-config --from-literal=erlang-cookie=wocloud-rabbitmq
