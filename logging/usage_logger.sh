#!/bin/bash
# example script that loops forever and, every 10 seconds, logs a messagge tagged local1.info containing (on one line) free RAM and the tuple username/pid/command of the process with highest CPU usage

while true ; do {

	#finds free RAM as number of bytes
	FREERAM=$(free | head -n 2 | tail -n +2 | awk '{print $3}')

	#creates temp file and writes the line with the highest CPU usage
	TEMP=$(mktemp)
	top -o %CPU -b -n2 | tail -n +8 | head -n 1 > $TEMP

	#estract fields from the line in the file
	USER=$(cat $TEMP | awk '{print $2}')
	PID=$(cat $TEMP | awk '{print $1}')
	COMMAND=$(cat $TEMP | awk '{print $12}')

	#logs message
	logger -p local1.info "$FREERAM, $USER $PID $COMMAND"
	
	#removes temp file
	rm -f $TEMP
	
	#active sleep may cause issues ...
	sleep 10;
}
done
