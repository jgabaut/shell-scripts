if [[ -f /etc/rsyslog.d/mylog.conf ]] ; then {
	TEMP=$(mktemp)
	grep -Fvx "local1.=info  /var/log/sd.log" "/etc/rsyslog.d/mylog.conf" | while read RIGA; do {
		echo "$RIGA" >> "$TEMP"
	} done
	mv "$TEMP" "/etc/rsyslog.d/mylog.conf"
	rm -f $TEMP
} 
fi
#idempotent addition of the log setting to rsyslog config

echo "local1.=info  /var/log/sd.log" >> /etc/rsyslog.d/mylog.conf
