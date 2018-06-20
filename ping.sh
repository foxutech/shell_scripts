#!/bin/bash
date
cat <<IP-LIST-FILE>> |  while read output
do
    ping -c 1 "$output" > /dev/null
    if [ $? -eq 0 ]; then
    echo "POP $output is up"
    else
    echo "POP $output is down"
    fi
done
