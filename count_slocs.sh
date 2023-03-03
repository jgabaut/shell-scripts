#!/bin/bash

# Define a function to count the non-empty and non-comment lines in a file
count_lines() {
  file=$1
  count=0
  inside_comment=false
  while read -r line; do
    # Check if we are inside a comment
    if $inside_comment; then
      # Check if the line ends with the end-of-comment marker */
      if [[ "$line" =~ \*/$ ]]; then
        inside_comment=false
      fi
    else
      # Check if the line starts with the comment marker /*
      if [[ "$line" =~ ^[[:space:]]*/\* ]]; then
        inside_comment=true
      # Check if the line is not empty and not a comment
      elif [[ "$line" =~ ^[^[:space:]] && ! "$line" =~ ^[[:space:]]*// ]]; then
        ((count++))
      fi
    fi
  done < "$file"
  echo "$file: $count non-empty, non-comment lines" >&2

  newtot=$((LNCNT_TOT+=$count))
}

# Define a function expecting a list of files that will output the total number of non-empty, non-comment lines
linecounter() {
  # Loop over the list of files and count the lines in each file
  export LNCNT_TOT=0;
  for file in "$@"; do
    count_lines "$file"
  done
  echo >&2
  echo -en "Total lines of code:\t" >&2
  echo "$LNCNT_TOT"
}

usage() {
	echo "Wrong arguments." >&2
	echo -e "Usage:\n\t$(basename $(readlink -f "${BASH_SOURCE}")) <directory>" >&2
	exit 1
}

# Check if invocation was correct
if ! test -d "$1" ; then {
	usage
}
fi

# Move into passed dir and pass every file with a program-like extension to linecounter()
DIR="$1"
cd "$DIR"	
linecounter $( 
	for F in $( ls | grep -E "(\.c$|\.h$|\.py$|\.sh$|\.bash$)" 
	); do { 
		if [[ -f "$F" ]] ; then {
			echo "$(pwd)/$F";  
		} elif [[ -d "$F" ]] ; then {
			(readlink -f "${BASH_SOURCE}" "$F")
		}		
		fi
	}; done
)
