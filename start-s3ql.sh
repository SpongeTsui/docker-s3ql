#!/bin/bash
tag="s3ql"

docker run --name s3ql -d -v /var/ehl-nas/:/var/ehl-nas/ -v /var/log/ehl-nas/:/var/log/ehl-nas/ -v /mnt/ehl-nas/:/mnt/ehl-nas/ -v /etc/ehl-nas/:/etc/ehl-nas/ ${tag}
