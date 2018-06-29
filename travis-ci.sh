#!/bin/bash

image_name="xebialabsunsupported/xl-docker-demo-mysql"
./dockertags mysql > /tmp/mysql
./dockertags $image_name > /tmp/xl
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
while read tag ; do
    docker build -t $image_name:$tag --build-arg mysql_tag=$tag .
    docker push $image_name:$tag
done < <(comm -23 <(sort /tmp/mysql) <(sort /tmp/xl))