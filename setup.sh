#!/usr/bin/env bash

rm docker.env
echo "PUID=$(id -u)" >> docker.env
echo "PGID=$(id -g)" >> docker.env
echo "TZ=$(readlink /etc/localtime | sed 's|.*/zoneinfo/||g')" >> docker.env