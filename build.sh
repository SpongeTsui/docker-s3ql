#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: ./build.sh <network address>"
    exit 1
fi

src="s3ql-2.23"
archive="s3ql-2.23.tar"
port="9090"
tag="s3ql"

if [ -d  $src ]
then
    echo "$src in place"
else
    echo "get source code"
    git clone ardev@10.2.162.140:~/s3ql-2.23
fi

if [ -f $archive ]
then
    echo "$archive in place"
else
    echo "tar source code"
    tar -cvf $archive $src >/dev/null
fi

python -m SimpleHTTPServer $port &
pid=$!

docker build -t ${tag} --build-arg server="http://${1}:${port}" .
echo "==================================="

kill -9 $pid
echo HTTP server was stopped.
echo Image ${tag} builded!
