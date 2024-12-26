#!/bin/bash
WORK_DIR=${0%/*}

# set permissions
chmod +x ${WORK_DIR}/bin/naive

# Set work directory
CONFIG_DIR="${WORK_DIR}/config"
PROGRAM="${WORK_DIR}/bin/naive"

# cd to work directory
cd $WORK_DIR || exit 1


for CONFIG_FILE in $CONFIG_DIR/*.json; do
    if [ -f "$CONFIG_FILE" ]; then
        echo "Launching config: $CONFIG_FILE"
        $PROGRAM -c "$CONFIG_FILE" &  # Start naive core
    else
        echo "Skip $CONFIG_FILE"
    fi
done

echo "Finished."
