#!/bin/bash -l

./twistcli coderepo scan --address https://$TL_CONSOLE -u $TL_USER -p $TL_PASS ./app 
result=$(curl -k -u $TL_USER:$TL_PASS -H 'Content-Type: application/json' "https://$TL_CONSOLE/api/v1/coderepos-ci?limit=1&reverse=true&sort=scanTime"|jq '.[0].pass')

if [ "$result" == "true" ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   exit 1
fi
