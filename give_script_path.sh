# The good old finding where the script you're running is residing.
#!/bin/bash
echo "$(readlink -f "${BASH_SOURCE}")"
echo "$(readlink -f "$0")"
