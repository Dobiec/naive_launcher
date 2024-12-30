#!/bin/bash

WORK_DIR=${0%/*}
# Query all the running naive processes.

# check if ksu
if ls /data/adb | grep -q "ksu"; then
    processes=$(/data/adb/ksu/bin/busybox ps aux | grep '/data/adb/modules/naive_launcher/bin/naive' | grep -v 'grep' | awk '{print $1}')
    /data/adb/ksu/bin/busybox sh /data/adb/modules/naive_launcher/action1.sh
elif ls /data/adb | grep -q "ap"; then
    processes=$(/data/adb/ap/bin/busybox ps aux | grep '/data/adb/modules/naive_launcher/bin/naive' | grep -v 'grep' | awk '{print $1}')
else
    echo "Error: Neither KernelSU nor Apatch found."
    exit 1
fi

echo "Found NaiveProxy Process:"
echo ${processes}

# Kill naive core
if [ -n "$processes" ]; then
    for pid in $processes; do
        echo "Killing processes: $pid"
        kill -9 $pid
    done
else
    echo "No naive process found to kill."
fi

sleep 2s
# launch naive core
echo "Starting NaiveProxy..."
sh ${WORK_DIR}/service.sh

sleep 2s