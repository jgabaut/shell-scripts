#grep -F turns off REs and seeks the parameter literally, 
# -x only matches whole lines, 
# -v inverts match so returns only lines NOT containing the expression;
#
# useful to only remove a specific line from a file, ie. to automate loggin removal in a config file using idempotent edits

TEMP=$(mktemp)
grep -Fvx "line" "$1" | while read LINE ; do {
echo "$LINE"  >> "$TEMP"
} 
done
mv "$TEMP" "$1"
rm -f $TEMP
