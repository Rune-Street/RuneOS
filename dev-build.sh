#!/bin/bash
cd "${0%/*}"

docker kill lxde-test &
sleep 2
docker rm lxde-test &
wait
docker build . -t "lxde:lxde" && docker run -d --name lxde-test -p 5901:5901 lxde:lxde
