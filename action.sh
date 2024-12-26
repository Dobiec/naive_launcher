#!/bin/bash

WORK_DIR=${0%/*}
# Query all the running naive processes.
processes=$(ps aux | grep '/data/adb/modules/naive_launcher/bin/naive' | grep -v 'grep' | awk '{print $1}')

# Kill naive core
if [ -n "$processes" ]; then
    echo "Killing processes: $processes"
    for pid in $processes; do
        kill -9 $pid
    done
else
    echo "No naive process found to kill."
fi

# launch naive core
echo "Starting NaiveProxy..."
sh ${WORK_DIR}/service.sh

sleep 5s