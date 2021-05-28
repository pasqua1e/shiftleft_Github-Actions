#!/bin/bash

host=$(echo $TL_CONSOLE | sed -e "s/console/dvwa/")
curl -s -u $TL_USER:$TL_PASS "https://$host/exec.php?script=$1"