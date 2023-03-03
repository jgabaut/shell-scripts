#grep -F turns off REs and seeks the parameter literally, 
# -x only matches whole lines, 
# -v inverts match so returns only lines NOT containing the expression;

TEMP=$(mktemp)
grep -Fvx "local1.=info  /var/log/sd.log" "/etc/rsyslog.d/mylog.conf" | while read LINE; do {
	echo "$LINE" >> "$TEMP"
} done
	mv "$TEMP" "/etc/rsyslog.d/mylog.conf"
	rm -f $TEMP

# turns off logging by removing the line from rsyslog config file
