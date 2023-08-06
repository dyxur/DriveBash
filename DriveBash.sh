#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
now="$(date +'%Y%m%d')"
errorsInBB=0
totalCounter=0
drive="$1"
logName="$2"

if [ -z "$drive" ]
then
    echo -e "${RED}Please provide path to drive. E.g. /dev/sdX${NC}"
   exit 1
fi

if [ -z "$logName" ]
then
    echo -e "${RED}Please provide a name for the log${NC}"
   exit 1
fi

touch "${now}_${logName}.log"

writeBash100() {
    counter=0

    for i in {1..99}; do
        shred -vzn 0 "$drive"
        echo "$i"
        ((counter++))
    done

    ## No console output, but works for now
    badBlocksResult=$( badblocks -wsv -b 512 -c 65536 "$drive" 2>&1 | tail -n 1 )

    ((counter++))

    echo "Drive was filled ${counter} times" >> $now.log

    (echo $badBlocksResult | grep -o -E "[0-9]* bad blocks found|([0-9]*/[0-9]*/[0-9]* errors)") | column >> $now.log
    errorsInBB=$((echo "Pass completed, 527405 bad blocks found. (0/0/527405 errors)" | grep -o -E "[0-9]* bad blocks found") | grep -o -E "[0-9]*")

    totalCounter=$((totalCounter+counter))
}

writeBash100
while (( $errorsInBB > 0 )); do
    writeBash100
    echo "Writes done: ${totalCounter}"
done
