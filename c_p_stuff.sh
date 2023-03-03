# This is not meant to be executed, I sometimes just copy and paste bits from here.


# test arg num
 if [[ $# -ne 3 ]] ; then
        echo "Wrong argument number"; exit 1;
 fi

# test if $1 is a digit string
if ! [[ "$1" =~ ^[0-9]+$ ]] ; then
	echo "$1 non only digits"
	exit 1
fi

# $1 must be essere directory, executable
if ! [[ -x "$1" && -d "$1" ]] ; then
        echo "$1 not an executable directory";
        exit 1;
fi

# $2 must be executable, normal file with absolute path 
if ! [[ -x "$2" && -f "$2" && "$2" =~ ^/ ]] ; then
	echo "$2 not an executable file with absolute path"
	exit 1
fi


# last access/edit to a $FILE, format seconds since epoch
LASTACCESS=$(stat --format='%X' "$FILE")
LASTMOD=$(stat --format='%Y' "$FILE")

# estracts a single line from file.txt
# Here LINE_NUMBER is, which line number you want to print. Examples: Print a line from single file.
head -n LINE_NUMBER file.txt | tail -n + LINE_NUMBER 

# checks if process is running as root or exits
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

# useful to get only uncommented lines out of config files
# puts on stdout lines from file filename not starting with (wsp)#, excluding empty lines 
# grep -v "^ *#" filename | grep -v "^$"
