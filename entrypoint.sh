#!/bin/bash

# Hand off to the CMD
if [[ "X$1" =~ X.*bash ]]; then
   CMD="$@ -rcfile /setupMe.sh"
   eval "set $CMD"
fi
exec "$@"

